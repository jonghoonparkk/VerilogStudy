module test_Hex_Keypad_Grayhill_072;

    // 출력 신호 정의
    wire [3:0] Code;
    wire       Valid;
    wire [3:0] Col, Row;

    // 입력 신호 정의
    reg        clock, reset;
    reg        S_Row;
    reg [15:0] Key;      // 키 입력
module test_Hex_Keypad_Grayhill_072;

    // 출력 신호 정의
    wire [3:0] Code;
    wire       Valid;
    wire [3:0] Col, Row;

    // 입력 신호 정의
    reg        clock, reset;
    reg        S_Row;
    reg [15:0] Key;      // 키 입력
    reg [39:0] Pressed;  // 디코딩된 키 출력

    // 파라미터 설정
    parameter Key_0 = "Key_0", Key_1 = "Key_1", Key_2 = "Key_2",
              Key_3 = "Key_3", Key_4 = "Key_4", Key_5 = "Key_5",
              Key_6 = "Key_6", Key_7 = "Key_7", Key_8 = "Key_8",
              Key_9 = "Key_9", Key_A = "Key_A", Key_B = "Key_B",
              Key_C = "Key_C", Key_D = "Key_D", Key_E = "Key_E",
              Key_F = "Key_F", None = "None";

    // Hex_Keypad_Grayhill_072 인스턴스화
    Hex_Keypad_Grayhill_072 uut (
        .Code(Code),
        .Valid(Valid),
        .Col(Col),
        .Row(Row),
        .S_Row(S_Row),
        .clock(clock),
        .reset(reset)
    );

    // 클럭 생성
    initial begin
        clock = 0;
        forever #5 clock = ~clock;
    end

    // 초기화 및 테스트 시나리오
    initial begin
        reset = 1;
        S_Row = 0;
        #10 reset = 0;

        // 키 입력을 시뮬레이션하여 각 키의 출력 확인
        Key = 16'h0001; #20; S_Row = 1; #10 S_Row = 0;  // Key_0
        Key = 16'h0002; #20; S_Row = 1; #10 S_Row = 0;  // Key_1
        Key = 16'h0004; #20; S_Row = 1; #10 S_Row = 0;  // Key_2
        Key = 16'h0008; #20; S_Row = 1; #10 S_Row = 0;  // Key_3
        Key = 16'h0010; #20; S_Row = 1; #10 S_Row = 0;  // Key_4
        Key = 16'h0020; #20; S_Row = 1; #10 S_Row = 0;  // Key_5
        Key = 16'h0040; #20; S_Row = 1; #10 S_Row = 0;  // Key_6
        Key = 16'h0080; #20; S_Row = 1; #10 S_Row = 0;  // Key_7
        Key = 16'h0100; #20; S_Row = 1; #10 S_Row = 0;  // Key_8
        Key = 16'h0200; #20; S_Row = 1; #10 S_Row = 0;  // Key_9
        Key = 16'h0400; #20; S_Row = 1; #10 S_Row = 0;  // Key_A
        Key = 16'h0800; #20; S_Row = 1; #10 S_Row = 0;  // Key_B
        Key = 16'h1000; #20; S_Row = 1; #10 S_Row = 0;  // Key_C
        Key = 16'h2000; #20; S_Row = 1; #10 S_Row = 0;  // Key_D
        Key = 16'h4000; #20; S_Row = 1; #10 S_Row = 0;  // Key_E
        Key = 16'h8000; #20; S_Row = 1; #10 S_Row = 0;  // Key_F

        #200 $finish;
    end
endmodule

    // Hex_Keypad_Grayhill_072 인스턴스화
    Hex_Keypad_Grayhill_072 uut (
        .Code(Code),
        .Valid(Valid),
        .Col(Col),
        .Row(Row),
        .S_Row(S_Row),
        .clock(clock),
        .reset(reset)
    );

    // 클럭 생성
    initial begin
        clock = 0;
        forever #5 clock = ~clock;
    end

    // 초기화 및 테스트 시나리오
    initial begin
        reset = 1;
        S_Row = 0;
        #10 reset = 0;

        // 각 키에 대해 테스트
        Key = 16'b0001_0000_0000_0000; #20 S_Row = 1; #10 S_Row = 0;
        Key = 16'b0000_1000_0000_0000; #20 S_Row = 1; #10 S_Row = 0;
        Key = 16'b0000_0100_0000_0000; #20 S_Row = 1; #10 S_Row = 0;
        Key = 16'b0000_0010_0000_0000; #20 S_Row = 1; #10 S_Row = 0;
        
        // 필요한 모든 테스트 시나리오를 반복하여 검증 가능

        #200 $finish;
    end
endmodule
