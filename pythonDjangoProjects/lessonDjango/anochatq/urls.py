from django.urls import path
from . import views

app_name="anochatq"

urlpatterns=[
	path('room/<str:pk>', views.roomView, name='room'),
	#path('room/<str:pk>', views.RoomView.as_view(), name='room'),
	path('all', views.AllView.as_view(), name='all'),
]
