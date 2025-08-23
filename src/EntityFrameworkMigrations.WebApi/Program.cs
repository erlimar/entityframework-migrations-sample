// Copyright (c) EntityFrameworkMigrations Team. All rights reserved.
// This file is part of EntityFrameworkMigrations and is licensed under the terms described in the LICENSE file.

using EntityFrameworkMigrations.EFCoreStorage.Repositories;
using EntityFrameworkMigrations.Models;
using EntityFrameworkMigrations.Orders;

using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddDbContext<AppDbContext>(
    options => options.UseNpgsql(builder.Configuration.GetConnectionString(nameof(AppDbContext))));

builder.Services.AddScoped<IOrdersRepository, OrdersEntityFrameworkRepository>();
builder.Services.AddSingleton(TimeProvider.System);

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    await using (var serviceScope = app.Services.CreateAsyncScope())
    await using (var dbContext = serviceScope.ServiceProvider.GetRequiredService<AppDbContext>())
    {
        await dbContext.Database.MigrateAsync();
    }

    app.UseSwagger();
    app.UseSwaggerUI();
}

app.MapPost("/orders", async (IOrdersRepository repo, TimeProvider timeProvider, [FromBody] CreateOrderCommand command) =>
{
    var order = await CreateOrderCommandHandler.Handle(command, repo, timeProvider);

    return Results.Created($"/orders/{order.Id}", order);
});

app.MapGet("/orders/{id}", async (IOrdersRepository repo, int id) =>
{
    var order = await GetOrderByIdQueryHandler.Handle(new GetOrderByIdQuery(id), repo);

    return order is null ? Results.NotFound() : Results.Ok(order);
});

app.Run();