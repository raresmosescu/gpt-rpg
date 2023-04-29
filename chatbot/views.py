from django.shortcuts import render
from django.views import View
from django.http import JsonResponse
from interface.conversation import Conversation
from game.models import Character


class ChatbotGetView(View):
    def get(self, request, *args, **kwargs):
        return render(request, "chatbot.html")


class ChatbotPostView(View):
    def post(self, request, *args, **kwargs):
        data = request.POST
        message = data.get("message")
        char1 = data.get("char1")
        char2 = data.get("char2")

        # get the character objects
        char1_obj = Character.objects.get(name=char1)
        char2_obj = Character.objects.get(name=char2)

        # create a conversation object
        conversation = Conversation(char1_obj, char2_obj)

        response = self.chatbot_response(conversation, message)
        return JsonResponse({"response": response})

    def chatbot_response(self, conversation, message):
        # Implement your chatbot logic here
        # Return the response to the user's message
        return conversation.talk(message)
