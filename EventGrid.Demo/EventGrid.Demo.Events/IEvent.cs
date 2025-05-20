namespace EventGrid.Demo.Events;

public interface IEvent
{
    public string Action { get; set; }
}
