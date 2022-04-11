from django.shortcuts import render, redirect, get_object_or_404

# Create your views here.
from django.urls.base import reverse_lazy
from django.views import generic
from django.urls import reverse
from .models import *
from .forms import SubmitForm

#class RoomView(generic.ListView, generic.edit.ModelFormMixin):
	#model = Message
	#form_class=SubmitForm
	#success_url=reverse_lazy("anochatq:room:"+self.kwargs["pk"])
	##template_name = 'lessonsets/person_list.html'
	#template_name = 'anochatq/room.html'
	#paginate_by = 5	
	#def get_context_data(self, **kwargs):
		#context = super().get_context_data(**kwargs)
		##context["title"]="room="+str(self.kwargs['pk'])
		#context["title"]="room="+self.kwargs['pk']
		#context["form"]=SubmitForm()
		#return context
	#def get_queryset(self, **kwargs):
			#queryset = super().get_queryset(**kwargs)
			#keyword = self.request.GET.get('keyword')
			#if keyword is not None:
				#queryset = queryset.filter(title__contains=keyword)
			##queryset = queryset.filter(room__roomID=self.kwargs['pk'])
			#queryset.order_by("time")
			#return queryset	
class AllView(generic.ListView):
	model=Message
	template_name="anochatq/all.html"
	def get_context_data(self, **kwargs):
		context = super().get_context_data(**kwargs)
		context["title"]="all"
		return context
	def get_queryset(self, **kwargs):
		queryset = super().get_queryset(**kwargs)
		keyword = self.request.GET.get('keyword')
		if keyword is not None:
			queryset = queryset.filter(title__contains=keyword)
		queryset.order_by("time")
		return queryset	

class RoomView(generic.CreateView):
	model=Message
	template_name = 'anochatq/room.html'
	fields=["text","room"]
	def get_initial(self):
		initial = super().get_initial()
		initial["room"] =self.kwargs["pk"]
		return initial	
	def get_success_url(self):
		return reverse("anochatq:room", kwargs={"pk":self.kwargs["pk"]})
	def get_form(self):
		if not Room.objects.filter(roomID=self.kwargs["pk"]).exists():
			newRoom=Room(roomID=self.kwargs["pk"])	
			newRoom.save()
		form=super(RoomView, self).get_form()
		form.fields["text"].required=True
		form.fields["room"].required=True
		return form
	def get_context_data(self, **kwargs):
		context=super().get_context_data(**kwargs)
		context["title"]="room="+self.kwargs["pk"]
		queryset=Message.objects.filter(room__roomID=self.kwargs["pk"])
		queryset=queryset.order_by("-time")[:5]
		context["message_list"]=queryset
		return context
	def form_valid(self, form):
		form.save()
		form.instance.save()
		form.instance.room_roomID = self.kwargs["pk"]
		print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
		print(self.kwargs["pk"])
		print(form.instance.room_roomID)
		form.save()
		return super(RoomView, self).form_valid(form)
	def form_invalid(self, form):
		messages.add_message(self.request, messages.WARNING, form.errors)
		return super().form_invalid(form)	

class RoomView2(generic.TemplateView):
	template_name="anochatq/room2"
	def get_context_data(self, **kwargs):
		context=super().get_context_data(**kwargs)
		context["title"]="room="+self.kwargs["pk"]
		queryset=Message.objects.filter(room__roomID=self.kwargs["pk"])
		queryset=queryset.order_by("-time")[:10]
		context["message_list"]=queryset
		context["form"]=form
		return context

def roomView(request, pk):
	if not Room.objects.filter(roomID=pk).exists():
		newRoom=Room(roomID=pk)	
		newRoom.save()
	room=get_object_or_404(Room, pk=pk)
	if request.method == 'POST':
		form = SubmitForm(request.POST)
		if form.is_valid():
			form.save(room)
			return redirect('anochatq:room', pk=room.roomID)
	else:
		form = SubmitForm()
	message_list=Message.objects.filter()
	message_list=Message.objects.filter(room=room)
	message_list=message_list.order_by("-time")[:10]
	title="room: "+room.roomID
	context = {"title":title, 'message_list':message_list, 'form':form}
	return render(request, "anochatq/roomview.html", context)	








