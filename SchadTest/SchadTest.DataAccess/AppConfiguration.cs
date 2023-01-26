
using System.Configuration;

namespace SchadTest.DataAccess
{
    public static class AppConfiguration
    {
        public static string ConnectionString => ConfigurationManager.ConnectionStrings["cn"].ConnectionString;
    }
}
