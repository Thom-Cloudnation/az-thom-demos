using Azure;
using Azure.Messaging.EventGrid;
using Microsoft.Extensions.DependencyInjection;

namespace EventGrid.Demo.Functions.Extensions;

public static class ServiceCollectionExtensions
{
    public static void AddEventGridClient(this IServiceCollection services, string domainEndpoint, string accessKey)
    {
        var credentials = new AzureKeyCredential(accessKey);
        var client = new EventGridPublisherClient(new Uri(domainEndpoint), credentials);
        services.AddScoped(x => client);
    }
}
