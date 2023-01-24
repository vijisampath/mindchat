defmodule Mindchat.GeckoApiTest do
  use ExUnit.Case

##Have to get current values of the coins and hardcode and then test this module


  @url "coins/list"
  @result [
  {"01coin", "01coin"},
  {"0chain", "0chain"},
  {"0x", "0x"},
  {"0xcert", "0xcert"},
  {"0xdao", "0xdao"}
  ]
    test "coins_list_id" do
    #  assert Mindchat.GeckoApi.coins_list_id() == @result
    end


  @nameresult [
  {"01coin", "01coin"},
  {"0chain", "Zus"},
  {"0x", "0x"},
  {"0xcert", "0xcert"},
  {"0xdao", "0xDAO"}
]
test "coins_list_name" do
#  assert Mindchat.GeckoApi.coins_list_name() == @nameresult
end

test "get_coin_list" do
#assert Mindchat.GeckoApi.get_coin_list("id") == @result
end

@get_coin_detail [[1673308800000, 17194.90932945318],
              [1673395200000, 17436.90232978116],
              [1673481600000, 17996.832553741606],
              [1673568000000, 18866.810330617045],
              [1673654400000, 19941.780543296303],
              [1673740800000, 21019.20661402266],
              [1673827200000, 20853.230569490253],
              [1673913600000, 21175.33773662521],
              [1674000000000, 21156.78393116713],
              [1674086400000, 20726.844969426445],
              [1674172800000, 21081.671022204326],
              [1674259200000, 22705.83367889906],
              [1674345600000, 22771.023287021784],
              [1674432000000, 22736.66142892971],
              [1674434541000, 22826.107910458737]]
test "get_coin_details" do
  id="bitcoin"
#  assert Mindchat.GeckoApi.get_coin_details(id) == @get_coin_detail
end

@market_chart %{"market_caps" => [
                [1673308800000, 331158152699.25574],
                [1673395200000, 335743942932.3494],
                [1673481600000, 345688973386.69006],
                [1673568000000, 363381125082.7658],
                [1673654400000, 382675302196.4898],
                [1673740800000, 405209898132.0056],
                [1673827200000, 401697403586.5178],
                [1673913600000, 407760358639.0028],
                [1674000000000, 407405144842.9396],
                [1674086400000, 399349603616.14526],
                [1674172800000, 406258441952.3726],
                [1674259200000, 436724993652.4275],
                [1674345600000, 438578588179.0604],
                [1674432545000, 437993799376.21344]
              ],
              "prices" => [
                [1673308800000, 17194.90932945318],
                [1673395200000, 17436.90232978116],
                [1673481600000, 17996.832553741606],
                [1673568000000, 18866.810330617045],
                [1673654400000, 19941.780543296303],
                [1673740800000, 21019.20661402266],
                [1673827200000, 20853.230569490253],
                [1673913600000, 21175.33773662521],
                [1674000000000, 21156.78393116713],
                [1674086400000, 20726.844969426445],
                [1674172800000, 21081.671022204326],
                [1674259200000, 22705.83367889906],
                [1674345600000, 22771.023287021784],
                [1674432545000, 22738.199833969848]
              ],
              "total_volumes" => [
                [1673308800000, 25532751567.198166],
                [1673395200000, 21858206845.29233],
                [1673481600000, 25439279072.98185],
                [1673568000000, 48025109150.17737],
                [1673654400000, 39514419053.17687],
                [1673740800000, 49498711311.53301],
                [1673827200000, 23072133987.553684],
                [1673913600000, 34809391745.54498],
                [1674000000000, 33278841336.508595],
                [1674086400000, 40612056908.80891],
                [1674172800000, 29144534677.57505],
                [1674259200000, 41321936668.62795],
                [1674345600000, 44077026803.66082],
                [1674432545000, 34335909360.730194]
              ]
}
test "coins_id_market_chart" do
  id="bitcoin"
  params=%{"days" => "14", "interval" => "daily", "vs_currency" => "usd"}
#  assert Mindchat.GeckoApi.coins_id_market_chart(id,params) == @market_chart
end


end
