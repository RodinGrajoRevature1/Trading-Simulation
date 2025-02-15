﻿using Models;

namespace RepoLayer
{
    public interface IdbsRequests
    {
        //Profiles Section
        Task<bool> CreateProfileAsync(string? userID, string? Name, string? Email, string? Picture ,int? Privacy);
        Task<bool> EditPortfolioAsync(Models.PortfolioDto p);
        Task<bool> EditProfileAsync(string? userID, string? Name, string? Email, string? Picture, int? Privacy);
        Task<Profile?> GetProfileByUserIDAsync(string userID);

        //Buy and Sell Section
        Task<bool> AddNewBuyAsync(Guid? PortfolioId, string? Symbol, decimal? CurrentPrice, decimal? AmountBought, decimal? PriceBought, DateTime? DateBought);
        Task<bool> AddNewSellAsync(Guid? PortfolioId, string? Symbol, decimal? amountSold, decimal? priceSold, DateTime? dateSold);
        Task<List<Buy?>> GetAllBuyBySymbolAsync(Models.Get_BuysDto AllBuys);
        Task<List<Sell?>> GetAllSellBySymbolAsync(Models.GetSellsDto sellsDto);

        //Portfolio Section
        Task<Portfolio?> GetPortfolioByPorfolioIDAsync(Guid? porfolioID);
        Task<List<Portfolio?>> GetALL_PortfoliosByUserIDAsync(string? userID);
        Task<bool> CreatePortfolioAsync(string auth0Id, PortfolioDto p);
        Task<Investment?> GetInvestmentByPortfolioIDAsync(Models.GetInvestmentDto investmentDto);
        Task<List<Investment>?> GetInvestmentByTimeAsync(GetInvestmentByTimeDto investmentByTime);

        //Homepage
        Task<int> GetNumberOfUsersAsync();
        Task<int> GetNumberOfPostsAsync();
        Task<int> GetNumberOfBuysByDayAsync();
        Task<int> GetNumberOfSellsByDayAsync();
    }
}