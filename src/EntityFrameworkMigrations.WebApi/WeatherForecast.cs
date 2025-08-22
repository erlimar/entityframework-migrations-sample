// Copyright (c) EntityFrameworkMigrations Team. All rights reserved.
// This file is part of EntityFrameworkMigrations and is licensed under the terms described in the LICENSE file.

namespace EntityFrameworkMigrations.WebApi;

public class WeatherForecast
{
    public DateOnly Date { get; set; }

    public int TemperatureC { get; set; }

    public int TemperatureF => 32 + (int)(TemperatureC / 0.5556);

    public string? Summary { get; set; }
}