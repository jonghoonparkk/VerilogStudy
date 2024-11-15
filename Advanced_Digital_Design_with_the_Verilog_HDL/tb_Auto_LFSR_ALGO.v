module tb_Auto_LFSR_ALGO;

    // 파라미터와 테스트 신호 정의
    parameter Length = 8;
    reg Clock;
    reg Reset;
    wire [1:Length] Y;

    // Auto_LFSR_ALGO 인스턴스화
    Auto_LFSR_ALGO #(Length, 8'b1001_0001, 8'b1111_0011) uut (
        .Clock(Clock),
        .Reset(Reset),
        .Y(Y)
    );

    // 클럭 생성 (50MHz)
    initial begin
        Clock = 0;
        forever #10 Clock = ~Clock;    // 10ns마다 클럭 반전
    end

    // 테스트 시나리오
    initial begin
        // 초기 상태 출력
        $display("시작 시점 Y = %b", Y);

        // 리셋 신호 활성화
        Reset = 0;
        #20;                           // 20ns 대기
        Reset = 1;                     // 리셋 비활성화
        #20;                           // 20ns 대기

        // 여러 클럭 주기 동안 LFSR 동작 확인
        repeat (20) begin
            #20;                       // 한 클럭 주기 대기
            $display("시간 %0t Y = %b", $time, Y); // 현재 시간과 Y 출력값 표시
        end

        $stop;                         // 시뮬레이션 정지
    end

endmodule
