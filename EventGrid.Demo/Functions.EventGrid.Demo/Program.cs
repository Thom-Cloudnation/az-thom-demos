using EventGrid.Demo.Functions.Extensions;
using EventGrid.Demo.Functions.Models.Configuration;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Builder;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

var builder = FunctionsApplication.CreateBuilder(args);

var config = new FunctionsConfiguration();
builder.Configuration.Bind(config);

builder.Services.AddEventGridClient(config.EventGridDomainEndpoint, config.EventGridAccessKey);

builder.ConfigureFunctionsWebApplication();

builder.Services
    .AddApplicationInsightsTelemetryWorkerService()
    .ConfigureFunctionsApplicationInsights();

builder.Build().Run();
