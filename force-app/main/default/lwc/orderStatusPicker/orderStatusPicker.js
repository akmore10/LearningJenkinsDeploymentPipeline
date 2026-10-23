import { LightningElement, api } from 'lwc';

export default class OrderStatusPicker extends LightningElement {
    // @api makes these available as Flow input/output variables.
    // The Flow stores the user's selection in selectedStatus and reads it
    // on the next screen or decision element.
    @api selectedStatus = '';

    statusOptions = [
        { label: 'Pending',    value: 'Pending'    },
        { label: 'Processing', value: 'Processing' },
        { label: 'Completed',  value: 'Completed'  },
        { label: 'Cancelled',  value: 'Cancelled'  }
    ];

    handleChange(event) {
        this.selectedStatus = event.detail.value;
    }
}
