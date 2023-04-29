from django.shortcuts import render


# Create your views here.
# this view will take in a prompt and return a reply
def prompt(request):
    if request.method == "POST":
        prompt = request.POST.get("prompt")
    return render(request, "conversation.html")
