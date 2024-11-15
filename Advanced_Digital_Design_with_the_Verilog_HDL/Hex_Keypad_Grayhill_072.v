// 모듈 정의: Hex_Keypad_Grayhill_072
module Hex_Keypad_Grayhill_072 (
    output reg [3:0] Code,     // 키패드 코드 값
    output           Valid,    // 유효한 입력 신호
    output reg [3:0] Col,      // 열 신호
    output reg [3:0] Row,      // 행 신호
    input            S_Row,    // 행 스캔 신호
    input            clock,    // 클럭 신호
    input            reset     // 리셋 신호
);

    // 상태 및 다음 상태 정의
    reg [5:0] state, next_state;

    // 원핫 상태 할당
    parameter S_0 = 6'b000001, S_1 = 6'b000010, S_2 = 6'b000100;
    parameter S_3 = 6'b001000, S_4 = 6'b010000, S_5 = 6'b100000;

    // 유효 신호 할당
    assign Valid = ((state == S_1) || (state == S_2) || (state == S_3) || (state == S_4) || (state == S_5)) && Row;

    // 키패드 코드 매핑
    always @ (Row, Col)
        case ({Row, Col})
            8'b0001_0001: Code = 0;
            8'b0001_0010: Code = 1;
            8'b0001_0100: Code = 2;
            8'b0001_1000: Code = 3;
            8'b0010_0001: Code = 4;
            8'b0010_0010: Code = 5;
            8'b0010_0100: Code = 6;
            8'b0010_1000: Code = 7;
            8'b0100_0001: Code = 8;
            8'b0100_0010: Code = 9;
            8'b0100_0100: Code = 10; // A
            8'b0100_1000: Code = 11; // B
            8'b1000_0001: Code = 12; // C
            8'b1000_0010: Code = 13; // D
            8'b1000_0100: Code = 14; // E
            8'b1000_1000: Code = 15; // F
            default: Code = 0;       // 임의 선택
        endcase

    // 상태 전이 블록
    always @ (posedge clock, posedge reset)
        if (reset == 1'b1) state <= S_0;
        else state <= next_state;

    // 상태 기반 논리
    always @ (state, S_Row, Row)
    begin
        next_state = S_0;
        Col = 0;  // 기본값 할당
        case (state)
            // 모든 열 확인
            S_0: begin Col = 15; if (S_Row) next_state = S_1; end
            S_1: begin Col = 1; if (Row) next_state = S_5; else next_state = S_2; end
            S_2: begin Col = 2; if (Row) next_state = S_5; else next_state = S_3; end
            S_3: begin Col = 4; if (Row) next_state = S_5; else next_state = S_4; end
            S_4: begin Col = 8; if (Row) next_state = S_5; else next_state = S_0; end
            S_5: begin Col = 15; if (S_Row == 0) next_state = S_0; else next_state = S_5; end
            default: next_state = S_0;
        endcase
    end
endmodule

// 모듈 정의: Synchronizer
module Synchronizer (
    output reg S_Row,           // 동기화된 행 스캔 신호
    input [3:0] Row,            // 입력 행 신호
    input clock,                // 클럭 신호
    input reset                 // 리셋 신호
);

    reg A_Row; // 중간 레지스터

    // 두 단계 파이프라인 동기화기
    always @ (negedge clock, posedge reset) begin
        if (reset == 1'b1) begin
            A_Row <= 0;
            S_Row <= 0;
        end else begin
            A_Row <= (Row[0] || Row[1] || Row[2] || Row[3]);
            S_Row <= A_Row;
        end
    end
endmodule

// 모듈 정의: Row_Signal
module Row_Signal (
    output reg [3:0] Row,   // 검출된 행 신호
    input [15:0] Key,       // 키 입력
    input [3:0] Col         // 열 신호
);

    // 키가 눌렸는지 확인하는 조합 논리
    always @ (Key, Col) begin
        Row[0] = Key[0] && Col[1] || Key[1] && Col[1] || Key[2] && Col[1] || Key[3] && Col[1];
        Row[1] = Key[4] && Col[1] || Key[5] && Col[1] || Key[6] && Col[1] || Key[7] && Col[1];
        Row[2] = Key[8] && Col[1] || Key[9] && Col[1] || Key[10] && Col[1] || Key[11] && Col[1];
        Row[3] = Key[12] && Col[1] || Key[13] && Col[1] || Key[14] && Col[1] || Key[15] && Col[1];
    end
endmodule

// 모듈 정의: Key_Decoder
module Key_Decoder (
    input [15:0] Key,            // 키 입력
    output reg [39:0] Pressed    // 디코딩된 키 이름
);

    // 키 디코딩 로직
    always @ (Key) begin
        case (Key)
            16'h0000: Pressed = "None";      // 아무 키도 눌리지 않음
            16'h0001: Pressed = "Key_0";
            16'h0002: Pressed = "Key_1";
            16'h0004: Pressed = "Key_2";
            16'h0008: Pressed = "Key_3";
            16'h0010: Pressed = "Key_4";
            16'h0020: Pressed = "Key_5";
            16'h0040: Pressed = "Key_6";
            16'h0080: Pressed = "Key_7";
            16'h0100: Pressed = "Key_8";
            16'h0200: Pressed = "Key_9";
            16'h0400: Pressed = "Key_A";
            16'h0800: Pressed = "Key_B";
            16'h1000: Pressed = "Key_C";
            16'h2000: Pressed = "Key_D";
            16'h4000: Pressed = "Key_E";
            16'h8000: Pressed = "Key_F";
            default:  Pressed = "None";      // 알 수 없는 상태
        endcase
    end
endmodule
