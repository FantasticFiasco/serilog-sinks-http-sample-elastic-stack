using Bogus;

namespace SerilogExample.Generators
{
    public class OrderGenerator
    {
        private readonly Faker<Order> faker;

        public OrderGenerator()
        {
            var currentOrderId = 0;
            var fruit = new[] { "apple", "banana", "orange", "strawberry", "kiwi" };

            faker = new Faker<Order>()
                .RuleFor(order => order.Id, _ => currentOrderId++)
                .RuleFor(order => order.Item, faker => faker.PickRandom(fruit))
                .RuleFor(order => order.Quantity, faker => faker.Random.Number(1, 10));
        }

        public Order Generate()
        {
            return faker.Generate();
        }
    }
}