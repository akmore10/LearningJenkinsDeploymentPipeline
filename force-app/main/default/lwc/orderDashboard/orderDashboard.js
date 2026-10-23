/**
 * DEPENDENCY: Imports from OrderController via @salesforce/apex.
 * When OrderController is deleted from the org, this component
 * must be deleted first (or in the same destructive deploy transaction).
 */
import { LightningElement, wire, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
import getPendingOrders from '@salesforce/apex/OrderController.getPendingOrders';
import getPendingOrderCount from '@salesforce/apex/OrderController.getPendingOrderCount';
import completeOrder from '@salesforce/apex/OrderController.completeOrder';

export default class OrderDashboard extends LightningElement {
    @wire(getPendingOrders) pendingOrders;
    @wire(getPendingOrderCount) pendingCount;

    @track isProcessing = false;

    handleComplete(event) {
        const orderId = event.target.dataset.id;
        this.isProcessing = true;

        completeOrder({ orderId })
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Order marked as completed.',
                        variant: 'success'
                    })
                );
                return refreshApex(this.pendingOrders);
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: error.body?.message ?? 'Unknown error',
                        variant: 'error'
                    })
                );
            })
            .finally(() => {
                this.isProcessing = false;
            });
    }
}
