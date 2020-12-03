# from mockito import mock, verify
import unittest
import numpy as np
import talib
import pandas as pd

from get_returns import get_returns


class Get_ReturnsTest(unittest.TestCase):

    close_prices = pd.DataFrame([962.9, 893.9, 884.2, 921.55, 969.3, 1041.45, 1082.45, 1081.3, 1102.4, 1075.4, 1047.65, 1036.8, 1129.95, 1110.5, 1044.25, 1074.95, 1066.9, 1060.2, 1156.8, 1199.9, 1211.65, 1249.1, 1268.8, 1296.85, 1307.45, 1275.8, 1240.35, 1227.25, 1204.8, 1180.25])[0]
    close_prices_w_prof =  pd.DataFrame([746.4 , 737.75, 735.65, 699.25, 669.25, 640.9 , 609.75, 601.15, 623.7 , 602.9 , 566.3 , 561.  , 511.45, 502.4 , 497.75, 469.2 ,497.15, 504.05, 516.  , 619.2 , 578.75, 592.2 , 608.35, 602.3 ,   593.2 , 593.4 , 589.65, 597.75, 608.6 , 610.2 , 642.55, 637.4 , 626.35, 645.15, 665.85, 666.7 , 665.25, 712.15, 736.45, 740.6 , 760.15, 766.65, 754.4 , 757.9 , 768.5 , 781.5 , 783.75, 807.55, 792.85, 789.2 , 790.85, 775.6 , 884.05, 901.35, 884.4 , 853.65, 887.45, 873.05, 841.  , 834.85])[0]
    
    def test_should_return_0_returns(self):
        
        out = get_returns(self.close_prices)
        print(out)
        
        assert out == 0
        # verify(out).write('0')

    def test_should_return_profit(self):
        
        out = get_returns(self.close_prices_w_prof)
        print(out)
        
        assert out == 52
