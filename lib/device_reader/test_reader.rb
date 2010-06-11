module DeviceReader
  class TestReader

    include Singleton

    LOGS =
    "ADA86506A0182400030200296C015407000200C3140154070301004A1400F701434ABAF70105F70E03FFD414000031152F4ABA6200803E000301000A0900F7012F4ABA1500F0D8FF03010004000089112F4ABA140078ECFF03010084000089114A69BA9800A086010301004A1400A9094369BAA90902A90C03007415000024152F69BA9800A086010301008A0200A9092F4DBB5B02C40900030100C30000A9090D4DBB5B0215FFFF2F55BB0102DC0500030300030000F9022F55BB5B02C40900030100030000F9022F55BB0002C40900030100030000F9022F55BB5B02C40900030100030000F9022F55BB0002C40900030100030000F9022F55BB0102DC0500" <<
    "AF0E0CC00008D5FF030100B60000CB0AAF430C0002C40900030100330000CB0A8D430C200215FBFFAF430C0002C40900030100330000CB0A8D430C200215FBFFAF430CC00078ECFF030100B60000CB0ACBB40C03010201008DB40C200215FDFFCA280DAB00F82A000301004A1400C50AC3280DC50A49C50B03FFFA1400000000AF280DAB00F82A00030100CA0900C50AAFA40D010B102700030100C30000C50A8DA40D010B15FFFFCAE90D7000905F010301004A14808F07C3E90D8F07048F7303007A150F006C15AFE90D1200000000030100050000C50AAFE90D7000905F01030100CA02808F07AF050E3900B036000301008300008F07AF120E4404E80300" <<
    "2FFAD5D700000000030100C81000E80A4A02D6CF00000000030100481400E80A4302D6E80A09E8000300000000FFF9142F02D6CF00000000030100C81000E80A4B0ED60C460201000D0ED6460215FFFF2FC4D98002080700030100C3000059020DC4D9800215FFFF4AF6DA9700D00700030A004B1400180343F6DA180301185A03FFBB1400FFBB142FF6DA9700D00700030A000B010018032FF6DA1500F0D8FF03010004000059022FF6DA1500F0D8FF03010084000059024B56DB024D0201000D56DB4D0215FFFF4BA1E0025B0201000DA1E05B0215FFFF4BA1E0025B0201000DA1E05B0215FFFF2F13E10002C40900030100C30000D4000D13E1200215FBFF" <<
    "2F87735202B00400030100C30000C5020D8773520215FFFF2F267A53041C0C00030100C30000C5020D267A530415FFFF2FA37C4A02DC0500030100C30000C5020DA37C4A0215FFFF2FF27E5102D00700030100C30000C5020DF27E510215FFFF062380BC14FF00D4032070BC14FF00D44AB5809800905F010301004A1480930143B580930102930C03007C15000049152FB5801200000000030100050000C5022FB6809800905F01030100CA028093014861839F0901020003000000004116000300000000000000030000000000003D0315000000000000030000000000000003000000008243484A6283FE00B03CFF0301004814009F094362839F09F99F00" <<
    "8DB01C610215FFFFAFB01C6102D00700030100C30000A2048DB01C610215FFFFCACF1C9000983A000301004A1400E40AC3CF1CE40A42E4010300DC1400000000AFD01C9000983A00030100CA0200E40ACA201D6600E0A5010301004A1480330AC3201D330A05338C03007C1500001815AF201D1200000000030100050000E40AAF201D6600E0A501030100CA0280330ACAA51D68005898000301004A1400E502C3A51DE50204E52303FFDC1400000000AFA51D6800589800030100CA0900E502AF141E4102B80B00030100C30000E5028D141E410215FFFFAF941E5102D00700030100C30000E5028D941E510215FFFFAFC21E5102D00700030100C30000E502" <<
    "435AFA130306130D03FFDD14000000002F5AFA7800983A00030100CA090013034A5DFA7800983A000301004A1400E502435DFAE50206E50D03FFDD14000000002F5DFA7800983A00030100CA0900E5022F06FD4104E80300030100C30000E5020D06FD410415FFFF4A13FD7B003075000301004A14007C034313FD7C03077C1B03FFDD1400FF7C142F13FD7B00307500030100CA09007C03862000BD14FF1000031DF0BD14FF1000CA910B7800983A000301004A1400A602C3910BA60206A60D03FFDD1400000000AF910B7800983A00030100CA0900A602CAE80B9200983A000301004A14009E0CC3E90B9E0C039E010300DD140000D614AFE90B9200983A00"

    attr_accessor :current_log_address

    START_LOG_ADDRESS = 0x50000
    END_LOG_ADDRESS = START_LOG_ADDRESS + LOGS.size / 2

    def initialize
      @current_log_address = START_LOG_ADDRESS
    end

    def raw_read(log_address = current_log_address)
      delay
      log_address = self.current_log_address if log_address > END_LOG_ADDRESS || log_address < START_LOG_ADDRESS
      position = (log_address - START_LOG_ADDRESS) * 2
      "#{log_address.to_address}:#{LOGS[position..position + 512]}"
    end

    def raw_status
      delay
      @current_log_address += (8 * (rand(3) + 1)) if rand(10) > 7
      @current_log_address = START_LOG_ADDRESS if @current_log_address >= END_LOG_ADDRESS
      "SL:#{START_LOG_ADDRESS.to_address} EL:#{END_LOG_ADDRESS.to_address} AL:#{self.current_log_address.to_address}\r\nSLSD:023B40 ELSD:423B40 ALSD:027AA3"
    end

    private

    def delay
      sleep rand(500).to_f / 1000
    end
  end
end