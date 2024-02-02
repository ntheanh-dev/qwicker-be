from .serializers import *
from .models import Job


def get_jobs_data(params):
    jobs_query = Job.objects.select_related('shipment', 'shipment__pick_up', 'shipment__delivery_address',
                                            'product', 'product__category', 'payment', 'payment__method', 'vehicle')
    if 'id' in params:
        jobs_query = jobs_query.filter(id=params['id'])
    if 'poster_id' in params:
        jobs_query = jobs_query.filter(poster_id=params['poster_id'])
    if 'status' in params:
        jobs_query = jobs_query.filter(status=params['status'])
    jobs_data = JobSerializer(jobs_query, many=True).data

    # print(jobs_query[1].shipment)

    for i in range(len(jobs_data)):
        # shipment
        jobs_data[i]['shipment'] = ShipmentSerializer(jobs_query[i].shipment).data
        jobs_data[i]['shipment']['pick_up'] = AddressSerializer(jobs_query[i].shipment.pick_up).data
        jobs_data[i]['shipment']['delivery_address'] = AddressSerializer(jobs_query[i].shipment.delivery_address).data
        # Product
        jobs_data[i]['product'] = ProductSerializer(jobs_query[i].product).data
        jobs_data[i]['product']['category'] = ProductCategorySerializer(jobs_query[i].product.category).data
        # Payment
        jobs_data[i]['payment'] = PaymentSerializer(jobs_query[i].payment).data
        jobs_data[i]['payment']['method'] = PaymentMethodSerializer(jobs_query[i].payment.method).data
        # Vehicle
        jobs_data[i]['vehicle'] = VehicleSerializer(jobs_query[i].vehicle).data
    return jobs_data
