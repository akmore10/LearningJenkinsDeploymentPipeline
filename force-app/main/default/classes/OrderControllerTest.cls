@IsTest
private class OrderControllerTest {

    @TestSetup
    static void makeData() {
        insert new List<OrderSummary__c>{
            new OrderSummary__c(Name = 'Pending Order 1', Status__c = 'Pending'),
            new OrderSummary__c(Name = 'Pending Order 2', Status__c = 'Pending'),
            new OrderSummary__c(Name = 'Completed Order', Status__c = 'Completed')
        };
    }

    @IsTest
    static void getPendingOrders_returnsOnlyPendingOrders() {
        Test.startTest();
        List<OrderSummary__c> result = OrderController.getPendingOrders();
        Test.stopTest();

        Assert.areEqual(2, result.size(), 'Should return both pending orders');
        for (OrderSummary__c order : result) {
            Assert.areEqual('Pending', order.Status__c, 'Returned orders should be pending');
        }
    }

    @IsTest
    static void completeOrder_changesOrderStatus() {
        OrderSummary__c order = [
            SELECT Id
            FROM OrderSummary__c
            WHERE Status__c = 'Pending'
            LIMIT 1
        ];

        Test.startTest();
        OrderController.completeOrder(order.Id);
        Test.stopTest();

        OrderSummary__c updated = [
            SELECT Status__c
            FROM OrderSummary__c
            WHERE Id = :order.Id
        ];
        Assert.areEqual('Completed', updated.Status__c, 'Order should be completed');
    }

    @IsTest
    static void getPendingOrderCount_returnsPendingOrderCount() {
        Test.startTest();
        Integer result = OrderController.getPendingOrderCount();
        Test.stopTest();

        Assert.areEqual(2, result, 'Should count both pending orders');
    }
}
