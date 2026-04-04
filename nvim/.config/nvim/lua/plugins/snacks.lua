return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = {
          hidden = true, -- Показувати приховані файли за замовчуванням
          ignored = true, -- (Опціонально) Показувати ігноровані git файли
        },
      },
    },
  },
}
