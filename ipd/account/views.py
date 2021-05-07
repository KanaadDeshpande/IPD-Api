from django.shortcuts import render


def welcomePage(request):
    return render(request, 'welcome.html')
