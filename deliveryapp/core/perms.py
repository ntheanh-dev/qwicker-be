from rest_framework import permissions


class JobOwner(permissions.IsAuthenticated):
    def has_object_permission(self, request, view, job):
        return request.user and request.user == job.poster