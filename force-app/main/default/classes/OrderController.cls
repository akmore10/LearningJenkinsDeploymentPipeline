/**
 * AuraEnabled controller for the orderDashboard LWC.
 * DEPENDENCY: Calls OrderService methods — OrderService must exist whenever
 * this class is deployed or validated. Deleting OrderService while this class
 * remains in the org will cause an immediate compilation failure.
 */
public with sharing class OrderController {

    @AuraEnabled(cacheable=true)
    public static List<OrderSummary__c> getPendingOrders() {
        return OrderService.getOrdersByStatus('Pending');
    }

    @AuraEnabled
    public static void completeOrder(Id orderId) {
        OrderService.updateOrderStatus(orderId, 'Completed');
    }

    @AuraEnabled(cacheable=true)
    public static Integer getPendingOrderCount() {
        return OrderService.countOrdersByStatus('Pending');
    }
}
