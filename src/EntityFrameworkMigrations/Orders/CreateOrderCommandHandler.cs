using System;
using System.Threading.Tasks;

namespace EntityFrameworkMigrations.Orders;

public class CreateOrderCommandHandler
{
    public static async Task<Order> Handle(CreateOrderCommand command, IOrdersRepository repo, TimeProvider timeProvider)
    {
        var newOrder = new Order
        {
            FirstName = command.FirstName,
            LastName = command.lastName,
            Status = "CREATED",
            CreateAt = timeProvider.GetUtcNow().UtcDateTime,
            TotalCost = command.TotalCost
        };

        return await repo.CreateOrderAsync(newOrder);
    }
}
