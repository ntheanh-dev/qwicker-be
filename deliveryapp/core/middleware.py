from django.utils.deprecation import MiddlewareMixin
from django.conf import settings
class ProvideClientIdAndClinetSecret(MiddlewareMixin):

    def process_view(self, request, view_func, view_args, view_kwargs):
        # Check if the view is a DRF login view and if it's a POST request
        print(settings.CLIENT_ID)
        print(settings.CLIENT_SECRET)
        if request.path == '/o/token/' and request.method == 'POST':
            print(request.data)
            # Add your custom data to the request

        return None