import json

from django.contrib import admin
from django.db.models import Count, Q, Sum
from django.db.models.functions import TruncMonth
from .serializers import JobSerializer
from .models import *


class UserAdmin(admin.ModelAdmin):
    list_display = ('name', 'email', 'created_date')

    @admin.display(empty_value="-")
    def name(self, obj):
        return f'{obj.first_name} {obj.last_name}'


class ShipperAdmin(admin.ModelAdmin):
    list_display = ('name', 'username', 'email', 'vehicle', 'vehicle_number', 'verified')
    search_fields = ('username',)

    actions = ('verify',)

    @admin.display(empty_value="-")
    def name(self, obj):
        return f'{obj.first_name} {obj.last_name}'

    @admin.display(empty_value="-")
    def vehicle(self, obj):
        return obj.more.vehicle

    @admin.display(empty_value="-")
    def vehicle_number(self, obj):
        return obj.more.vehicle_number

    def verify(self, request, queryset):
        queryset.update(verified=True)
        self.message_user(request, 'The selected shipper have been verified')


class JobAdmin(admin.ModelAdmin):
    change_list_template = 'admin/job_change_list.html'

    def changelist_view(self, request, extra_context=None):
        response = super().changelist_view(
            request,
            extra_context=extra_context,
        )
        query = Job.objects.all()
        job = Job.objects.aggregate(
            total=Count('pk'),
            pending=Count('pk', filter=(Q(status=Job.Status.FINDING_SHIPPER) | Q(status=Job.Status.WAITING_PAY))),
            shipping=Count('pk', filter=Q(status=Job.Status.WAITING_SHIPPER)),
            done=Count('pk', filter=Q(status=Job.Status.DONE)),
        )

        shipments = Shipment.objects.annotate(month=TruncMonth('shipment_date')).values('month').annotate(
            total_cost=Sum('cost'), count_shipment=Count('pk'))
        labels = []
        cost_data = []
        shipment_count_data = []
        for s in shipments:
            labels.append(s['month'].strftime('%b'))
            cost_data.append(float(s['total_cost'] / 1000000))
            shipment_count_data.append(s['count_shipment'])

        response.context_data['job'] = job
        response.context_data['shipment'] = json.dumps({'labels': labels, 'cost_data': cost_data,'shipment_count_data': shipment_count_data})
        response.context_data['shipment_data'] = JobSerializer(query,many=True).data
        return response


admin.site.register(User, UserAdmin)
admin.site.register(Shipper, ShipperAdmin)
admin.site.register(Job, JobAdmin)
