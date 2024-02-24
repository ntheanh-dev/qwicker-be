from django.http import QueryDict
from django.utils.deprecation import MiddlewareMixin
from django.conf import settings


class ProvideClientIdAndClinetSecret(MiddlewareMixin):

    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        if request.method == 'POST' and (request.path == '/auth/token/' or request.path == '/auth/convert-token/'):
            post_data = request.POST.copy()
            post_data['client_id'] = settings.OAUTH2_TOOLKIT_CLIENT_ID
            post_data['client_secret'] = settings.OAUTH2_TOOLKIT_CLIENT_SECRET

            new_querydict = QueryDict('', mutable=True)
            new_querydict.update(post_data)

            request.POST = new_querydict

        response = self.get_response(request)
        return response

