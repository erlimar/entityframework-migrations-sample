using System.Threading.Tasks;

namespace EntityFrameworkMigrations.Orders;

public class GetOrderByIdQueryHandler
{
    public static async Task<Order?> Handle(GetOrderByIdQuery query, IOrdersRepository repo)
    {
        return await repo.GetOrderByIdAsync(query.OrderId);
    }
}
