namespace EntityFrameworkMigrations.Orders;

public record class CreateOrderCommand(string FirstName, string lastName, decimal TotalCost);
