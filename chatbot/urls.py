from django.urls import path
from .views import ChatbotGetView, ChatbotPostView

urlpatterns = [
    path("", ChatbotGetView.as_view(), name="chatbot_get"),
    path("response/", ChatbotPostView.as_view(), name="chatbot_post"),
    # ... other paths ...
]
