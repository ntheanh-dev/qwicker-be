from django.http import QueryDict
from django.utils.deprecation import MiddlewareMixin
from django.conf import settings


class ProvideClientIdAndClinetSecret(MiddlewareMixin):

    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        post_data = request.POST.copy()
        post_data['client_id'] = settings.CLIENT_ID
        post_data['client_secret'] = settings.CLIENT_SECRET

        new_querydict = QueryDict('', mutable=True)
        new_querydict.update(post_data)

        request.POST = new_querydict

        response = self.get_response(request)

        return response
