﻿using System;
using System.Threading.Tasks;
using Chiron.Auth.WebApi.Data;
using Chiron.Auth.WebApi.Services;
using Moq;
using Xunit;

namespace Chiron.Auth.Tests.Services {

    public class AuthenticatorTest : BaseTestFixture {
        Authenticator target;
        Mock<IUserDbContextFactory> ctxFactoryMock;
        Mock<IUserDbContext> dbCtxMock;
        Mock<IHashProvider> hashProviderMock;

        public AuthenticatorTest() {
            ctxFactoryMock = new Mock<IUserDbContextFactory>();
            hashProviderMock = new Mock<IHashProvider>();
            dbCtxMock = new Mock<IUserDbContext>();

            ctxFactoryMock.Setup(x => x.NewUserDbContext()).Returns(dbCtxMock.Object);

            target = new Authenticator(ctxFactoryMock.Object, hashProviderMock.Object);
        }

        [Fact]
        public async Task ShouldBeAbleToAuthenticate() {
            //Arrange
            var info = CreateTestData<LoginInfo>();
            var user = CreateTestData<User>();
            Arrange(() => {
                user.Username = info.Username;

                hashProviderMock.Setup(x => x.ComputeHash(info.Password + user.Salt)).Returns(user.Password);
                var usersMock = MockAsyncQueryable(user);
                dbCtxMock.Setup(x => x.Users).Returns(usersMock.Object);
            });

            //Act
            var result = await target.AuthenticateAsync(info);

            //Assert
            Assert.Same(user, result);
        }

        [Fact]
        public async Task ShouldBeAbleToAuthenticate_WrongPassword() {
            //Arrange
            var info = CreateTestData<LoginInfo>();
            Arrange(() => {
                var user = CreateTestData<User>();
                user.Username = info.Username;
                hashProviderMock.Setup(x => x.ComputeHash(info.Password)).Returns(Guid.NewGuid().ToString());
                var usersMock = MockAsyncQueryable(user);
                dbCtxMock.Setup(x => x.Users).Returns(usersMock.Object);
            });

            //Act
            var result = await target.AuthenticateAsync(info);

            //Assert
            Assert.Null(result);
        }

        [Fact]
        public async Task ShouldBeAbleToAuthenticate_UserNotFound() {
            //Arrange
            var info = CreateTestData<LoginInfo>();
            Arrange(() => {
                var user = CreateTestData<User>();
                var usersMock = MockAsyncQueryable(user);
                dbCtxMock.Setup(x => x.Users).Returns(usersMock.Object);
            });

            //Act
            var result = await target.AuthenticateAsync(info);

            //Assert
            Assert.Null(result);
        }

    }
}
