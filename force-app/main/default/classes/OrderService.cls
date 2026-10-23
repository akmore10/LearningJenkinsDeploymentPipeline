/**
 * Service layer for OrderSummary__c operations.
 * DEPENDENCY: Directly references OrderSummary__c object and Status__c field.
 * Deleting either of those metadata components requires removing or redeploying
 * this class first, otherwise Salesforce will throw a compilation error.
 */
public with sharing class OrderService {

    public static List<OrderSummary__c> getOrdersByStatus(String status) {
        return [
            SELECT Id, Name, Status__c
            FROM OrderSummary__c
            WHERE Status__c = :status
            WITH USER_MODE
        ];
    }

    public static void updateOrderStatus(Id orderId, String newStatus) {
        OrderSummary__c order = new OrderSummary__c(
            Id = orderId,
            Status__c = newStatus
        );
        update as user order;
    }

    public static Integer countOrdersByStatus(String status) {
        return [
            SELECT COUNT()
            FROM OrderSummary__c
            WHERE Status__c = :status
            WITH USER_MODE
        ];
    }
}
