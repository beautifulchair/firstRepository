from django import forms
from .models import Message, Room 
 
 
#class SubmitForm(forms.ModelForm):
    #class Meta:
        #model = Message
        #fields = ('text',)
	
class SubmitForm(forms.Form):
	text=forms.CharField(widget=forms.Textarea, max_length=300, label="")
	def save(self, room):
		inputText=self.cleaned_data.get("text")
		message=room.message_set.create(text=inputText)
		message.save()
