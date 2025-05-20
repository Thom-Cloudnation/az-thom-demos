namespace EventGrid.Demo.Events;

public class OrderPlacedEvent : IEvent
{
    public string Action { get; set; } = "OrderPlaced";

    public string OrderId { get; set; }
}
