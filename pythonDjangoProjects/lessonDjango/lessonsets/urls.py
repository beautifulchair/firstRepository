from django.urls import path
from . import views

app_name = 'lessonsets'

urlpatterns = [
    path('person/', views.PersonListView.as_view(), name='personlist'),
    path('person/pagenation', views.PersonPagenationView.as_view(), name='personpagenation'),
    path('person/<str:pk>', views.PersonView.as_view(), name='person'),
    path('createperson', views.PersonCreateView.as_view(), name='createperson'),
    path('deletePerson/<str:pk>', views.PersonDeleteView.as_view(), name='deleteperson'),
    path('updateperson/<str:pk>', views.PersonUpdateView.as_view(), name='updateperson'),
]