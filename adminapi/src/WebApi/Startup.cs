using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using Chiron.Admin.BootStrap;
using Chiron.Admin.BootStrap.Installer;
using Cortside.Common.BootStrap;
using Cortside.Common.IoC;
using Cortside.Common.Web.Mvc;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authentication.OAuth.Claims;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using Newtonsoft.Json.Serialization;

namespace Chiron.Admin.WebApi {

    public class Startup {
        private readonly BootStrapper bootstrapper = null;
        private readonly IHostingEnvironment env;

        public IConfiguration Configuration { get; }

        public Startup(IHostingEnvironment hostingEnv, IConfiguration configuration) {
            this.env = hostingEnv;
            //convert Enums to Strings (instead of Integer) globally
            JsonConvert.DefaultSettings = (() => {
                var settings = new JsonSerializerSettings();
                settings.Converters.Add(new StringEnumConverter { CamelCaseText = true });
                return settings;
            });

            bootstrapper = new DefaultApplicationBootStrapper();
            bootstrapper.AddInstaller(new WebApiInstaller());
            Configuration = configuration;

        }

        public void ConfigureServices(IServiceCollection services) {
            services.AddCors(options => options.AddPolicy("AllowAll", p => p.AllowAnyOrigin().AllowAnyHeader().AllowAnyMethod().AllowCredentials().SetPreflightMaxAge(new TimeSpan(0, 15, 0)).Build()));

            services
            .AddMvc()
            .AddJsonOptions(options => {
                options.SerializerSettings.ContractResolver = new CamelCasePropertyNamesContractResolver();
                options.SerializerSettings.Converters.Add(new StringEnumConverter { CamelCaseText = true });
                options.SerializerSettings.ReferenceLoopHandling = ReferenceLoopHandling.Ignore;
            });

            services.AddRouting(options => {
                options.LowercaseUrls = true;
            });

            JwtSecurityTokenHandler.DefaultInboundClaimTypeMap.Clear();

            var authConfig = Configuration.GetSection("Auth");
            services.AddAuthentication(options => {
                options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
                options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
            }).AddJwtBearer(o => {
                o.Authority = authConfig.GetValue<string>("Provider");
                o.Audience = authConfig.GetValue<string>("ApiName");
                o.RequireHttpsMetadata = authConfig.GetValue<bool>("RequireHttpsMetadata");
                o.TokenValidationParameters.RoleClaimType = "role";
                o.TokenValidationParameters.NameClaimType = "name";
            });

            //services.AddAuthorization(options => {
            //    options.AddPolicy("admin", policyBuilder => policyBuilder.RequireClaim("role", "admin"));
            //});

            services.AddPolicyServerClient(Configuration.GetSection("Policy"))
                .AddAuthorizationPermissionPolicies();

            bootstrapper.InitIoCContainer(Configuration as IConfigurationRoot, services);
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env, ILoggerFactory loggerFactory) {
            app.UseCors("AllowAll");

            app.UseStaticFiles();
            app.UseExceptionHandler();
            app.UseGenericExceptionHandler().UseHttpException();

            app.UseAuthentication();
            // this will map all of the policyserver defined roles and permissions to authorization policies
            app.UsePolicyServerClaimsTransformation();
            app.UseMvc();
        }
    }
}
