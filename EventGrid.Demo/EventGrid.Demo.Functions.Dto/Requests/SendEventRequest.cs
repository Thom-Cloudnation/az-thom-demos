using EventGrid.Demo.Events;

namespace EventGrid.Demo.Functions.Dto.Requests;

public class SendEventRequest
{
    public string Topic { get; set; }
    public string Id { get; set; }
    public string EventType { get; set; }
    public object EventData { get; set; }
}
