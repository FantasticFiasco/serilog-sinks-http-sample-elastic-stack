using System;
using System.Threading;
using Serilog;
using Serilog.Sinks.Http.BatchFormatters;

namespace ElasticStackExample
{
    public class Program
    {
        static void Main()
        {
            ILogger logger = new LoggerConfiguration()
                .WriteTo.DurableHttp(
                    requestUri: "http://logstash:31311",
                    batchFormatter: new ArrayBatchFormatter())
                .WriteTo.Console()
                .CreateLogger()
                .ForContext<Program>();

            var currentUser = new User { FirstName = "John", Surname = "Doe" };

            for (int i = 0; i < 5; i++)
            {
                logger.Information(
                    "Logging heartbeat from {@User} on {Computer}",
                    currentUser,
                    Environment.MachineName);

                Thread.Sleep(1000);
            }
        }
    }
}
