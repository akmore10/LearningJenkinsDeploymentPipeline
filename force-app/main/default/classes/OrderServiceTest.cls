@IsTest
private class OrderServiceTest {

    @TestSetup
    static void makeData() {
        List<OrderSummary__c> orders = new List<OrderSummary__c>{
            new OrderSummary__c(Status__c = 'Pending'),
            new OrderSummary__c(Status__c = 'Pending'),
            new OrderSummary__c(Status__c = 'Completed')
        };
        insert orders;
    }

    @IsTest
    static void getOrdersByStatus_returnsPendingOrders() {
        Test.startTest();
        List<OrderSummary__c> result = OrderService.getOrdersByStatus('Pending');
        Test.stopTest();

        Assert.areEqual(2, result.size(), 'Should return 2 pending orders');
    }

    @IsTest
    static void getOrdersByStatus_returnsEmptyListForUnknownStatus() {
        Test.startTest();
        List<OrderSummary__c> result = OrderService.getOrdersByStatus('Unknown');
        Test.stopTest();

        Assert.isTrue(result.isEmpty(), 'Should return empty list for unrecognised status');
    }

    @IsTest
    static void updateOrderStatus_changesStatusSuccessfully() {
        OrderSummary__c order = [SELECT Id FROM OrderSummary__c WHERE Status__c = 'Pending' LIMIT 1];

        Test.startTest();
        OrderService.updateOrderStatus(order.Id, 'Completed');
        Test.stopTest();

        OrderSummary__c updated = [SELECT Status__c FROM OrderSummary__c WHERE Id = :order.Id];
        Assert.areEqual('Completed', updated.Status__c, 'Status should be updated to Completed');
    }

    @IsTest
    static void countOrdersByStatus_returnsCorrectCount() {
        Test.startTest();
        Integer count = OrderService.countOrdersByStatus('Pending');
        Test.stopTest();

        Assert.areEqual(2, count, 'Should count 2 pending orders');
    }

    @IsTest
    static void countOrdersByStatus_returnsZeroForNoMatch() {
        Test.startTest();
        Integer count = OrderService.countOrdersByStatus('Cancelled');
        Test.stopTest();

        Assert.areEqual(0, count, 'Should return 0 for a status with no matching records');
    }
}
