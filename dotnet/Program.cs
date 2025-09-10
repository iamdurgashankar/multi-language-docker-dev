using Microsoft.AspNetCore.Mvc;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// Add CORS
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll",
        builder =>
        {
            builder
                .AllowAnyOrigin()
                .AllowAnyMethod()
                .AllowAnyHeader();
        });
});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseCors("AllowAll");

app.UseAuthorization();

app.MapControllers();

// Health check endpoint
app.MapGet("/health", () => new
{
    status = "healthy",
    service = "dotnet-api",
    timestamp = DateTime.UtcNow
});

// Events API endpoints
var events = new List<object>
{
    new { id = 1, name = "Tech Conference 2024", date = "2024-03-15", location = "San Francisco", attendees = 500 },
    new { id = 2, name = "DevOps Workshop", date = "2024-04-20", location = "New York", attendees = 150 },
    new { id = 3, name = "Cloud Summit", date = "2024-05-10", location = "Seattle", attendees = 1200 }
};

app.MapGet("/api/events", () => events);

app.MapGet("/api/events/{id}", (int id) =>
{
    var eventItem = events.FirstOrDefault(e => ((dynamic)e).id == id);
    return eventItem is not null ? Results.Ok(eventItem) : Results.NotFound();
});

app.MapPost("/api/events", ([FromBody] dynamic eventData) =>
{
    var newEvent = new
    {
        id = events.Count + 1,
        name = (string)eventData.name,
        date = (string)eventData.date,
        location = (string)eventData.location,
        attendees = (int)eventData.attendees,
        created_at = DateTime.UtcNow
    };
    
    events.Add(newEvent);
    return Results.Created($"/api/events/{newEvent.id}", newEvent);
});

app.MapPut("/api/events/{id}", (int id, [FromBody] dynamic eventData) =>
{
    var eventIndex = events.FindIndex(e => ((dynamic)e).id == id);
    if (eventIndex == -1)
        return Results.NotFound();

    var updatedEvent = new
    {
        id = id,
        name = (string)eventData.name,
        date = (string)eventData.date,
        location = (string)eventData.location,
        attendees = (int)eventData.attendees,
        updated_at = DateTime.UtcNow
    };

    events[eventIndex] = updatedEvent;
    return Results.Ok(updatedEvent);
});

app.MapDelete("/api/events/{id}", (int id) =>
{
    var eventIndex = events.FindIndex(e => ((dynamic)e).id == id);
    if (eventIndex == -1)
        return Results.NotFound();

    events.RemoveAt(eventIndex);
    return Results.Ok(new { message = "Event deleted successfully" });
});

app.Run();