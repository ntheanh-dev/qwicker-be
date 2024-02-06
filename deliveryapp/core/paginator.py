from rest_framework.pagination import PageNumberPagination
from rest_framework.views import Response


class JobPaginator(PageNumberPagination):
    page_size = 2

    def get_paginated_response(self, data):
        return {
            'links': {
                'next': self.get_next_link(),
                'previous': self.get_previous_link()
            },
            'count': self.page.paginator.count,
            'results': data
        }
