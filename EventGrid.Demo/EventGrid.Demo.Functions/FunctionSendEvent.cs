using Azure.Messaging.EventGrid;
using EventGrid.Demo.Functions.Dto.Requests;
using EventGrid.Demo.Functions.Dto.Responses;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;

namespace Functions.EventGrid.Demo;

public class FunctionSendEvent(ILogger<FunctionSendEvent> _logger, EventGridPublisherClient _eventPublisherClient)
{

    [Function("FunctionSendEvent")]
    public async Task<IActionResult> RunAsync([HttpTrigger(AuthorizationLevel.Function, "post")] HttpRequest req)
    {
        _logger.LogInformation("C# HTTP trigger function processed a request.");

        var request = await GetRequestAsync(req);
        SendEventResponse response;

        try
        {
            await SendEventToEventGrid(request);
            response = new SendEventResponse
            {
                Success = true,
                Message = $""
            };
        }
        catch (Exception ex)
        {
            response = new SendEventResponse
            {
                Success = false,
                Message = $"{ex.Message}"
            };
        }

        _logger.LogInformation($"Response: {JsonConvert.SerializeObject(response)}");

        return new OkObjectResult(response);
    }

    private async Task<SendEventRequest> GetRequestAsync(HttpRequest request)
    {
        request.EnableBuffering(); // Allows rereading the body if needed

        using var reader = new StreamReader(request.Body, leaveOpen: true);
        var body = await reader.ReadToEndAsync();

        _logger.LogInformation($"Request: {body}");

        request.Body.Position = 0;

        return JsonConvert.DeserializeObject<SendEventRequest>(body) ?? throw new JsonSerializationException("Could not deserialize the request body.");
    }

    private async Task SendEventToEventGrid(SendEventRequest request)
    {
        try
        {
            var topic = request.Topic; // The domain topic 

            EventGridEvent eventGridEvent = new EventGridEvent(
                subject: $"/{request.Topic}/{request.Id}",
                eventType: request.EventType,
                dataVersion: "1.0",
                data: request.EventData
            )
            {
                Topic = topic
            };

            await _eventPublisherClient.SendEventAsync(eventGridEvent);
            Console.WriteLine("Event sent successfully.");
        }
        catch (Exception e)
        {
            var x = e;
        }
    }
}