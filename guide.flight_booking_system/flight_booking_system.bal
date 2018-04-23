import ballerina/mb;
import ballerina/log;

endpoint mb:SimpleQueueReceiver queueReceiverBooking {
    host:"localhost",
    port:5672,
    queueName:"NewBookingsQueue"
};

endpoint mb:SimpleQueueReceiver queueReceiverCancelling {
    host:"localhost",
    port:5672,
    queueName:"BookingCancellationQueue"
};


service<mb:Consumer> bookingListener bind queueReceiverBooking {
    onMessage(endpoint consumer, mb:Message message) {
        string messageText = check message.getTextMessageContent();
        log:printInfo("[NEW BOOKING] Details : " + messageText);
    }
}

service<mb:Consumer> cancellingListener bind queueReceiverCancelling {
    onMessage(endpoint consumer, mb:Message message) {
        string messageText = check message.getTextMessageContent();
        log:printInfo("[CANCEL BOOKING] : " + messageText);
    }
}
