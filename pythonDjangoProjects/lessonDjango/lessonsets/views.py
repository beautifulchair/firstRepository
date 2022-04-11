from django.urls.base import reverse_lazy
from django.views import generic
from django.urls import reverse
from .models import *

# view all person
class PersonListView(generic.ListView):
    model = Person
    #template_name = 'lessonsets/person_list.html'
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'personlist'
        return context

class PersonPagenationView(generic.ListView):
    model = Person
    #template_name = 'lessonsets/person_list.html'
    template_name = 'lessonsets/person_pagenation.html'
    paginate_by = 3
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'personpagenation:'
        return context


# view each person
class PersonView(generic.DetailView):
    model = Person
    #template_name = 'lessonsets/person_detail.html'
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'person:'+self.object.pk
        return context

# to create new person 
class PersonCreateView(generic.CreateView):
    model = Person
    #template_name = 'lessonsets/person_form.html'
    fields = ['name', 'gender']
    def get_success_url(self):
        return reverse('lessonsets:person', kwargs={'pk': self.object.pk})
    def get_form(self):
        form = super(PersonCreateView, self).get_form()
        form.fields['name'].required = True
        return form
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'createperson'
        return context 

# to delete person
class PersonDeleteView(generic.DeleteView):
    model = Person
    #template_name = 'lessonsets/person_comfirm_delete.html'
    success_url = reverse_lazy('lessonsets:personlist')
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'deleteperson:'+self.object.pk
        return context

# to update person
class PersonUpdateView(generic.UpdateView):
    model = Person
    #template_name = 'lessonsets/person_form.html_'
    template_name = 'lessonsets/person_update.html'
    fields = ['gender']
    def get_success_url(self):
        return reverse('lessonsets:person', kwargs={'pk': self.object.pk})
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'updateperson'+self.object.pk
        return context
