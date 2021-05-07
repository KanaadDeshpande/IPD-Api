from django.urls import include, path
from knox import views as knox_views
from knox.views import LogoutView

from .api import *
from .views import welcomePage

urlpatterns = [
    path('user-register/', RegisterUser.as_view(), name='user-register'),
    path('login/', LoginAPIView.as_view(), name='login'),
    path('logout/', knox_views.LogoutView.as_view(), name='logout'),
    path('logoutall/', knox_views.LogoutAllView.as_view(), name='logoutall'),
    path('users-display/', UserDisplayView.as_view(), name='user-display-all'),
    path('users-display/<int:pk>/', UserDisplayView.as_view(),
         name='user-display-single'),
    path('', welcomePage),
    path('user/', UserAPIView.as_view()),
]
