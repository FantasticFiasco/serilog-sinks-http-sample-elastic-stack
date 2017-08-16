using Bogus;

namespace SerilogExample.Generators
{
    public class CustomerGenerator
    {
        private readonly Faker<Customer> faker;

        public CustomerGenerator()
        {
            var randomizer = new Randomizer();

            faker = new Faker<Customer>()
                .RuleFor(customer => customer.FirstName, faker => faker.Name.FirstName())
                .RuleFor(customer => customer.Surname, faker => faker.Name.LastName())
                .RuleFor(customer => customer.SocialSecurityNumber, _ => randomizer.Replace("###-##-####"));
        }

        public Customer Generate()
        {
            return faker.Generate();
        }
    }
}