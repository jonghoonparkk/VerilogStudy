module Auto_LFSR_ALGO #(parameter
    Length = 8,                        // LFSR의 길이 설정
    initial_state = 8'b1001_0001,      // LFSR의 초기 상태
    Tap_Coefficient = 8'b1111_0011     // 탭 계수 설정 (XOR 연산에 사용)
)(
    input Clock, Reset,                // 클럭과 리셋 입력
    output reg [1:Length] Y            // LFSR 출력 레지스터
);

integer Cell_ptr;

always @ (posedge Clock) begin         // 클럭 상승 에지에서 실행
    if (Reset == 1'b0)                 // 리셋이 활성화되면
        Y <= initial_state;            // 초기 상태로 설정
    else begin
        for (Cell_ptr = 2; Cell_ptr <= Length; Cell_ptr = Cell_ptr + 1) begin
            if (Tap_Coefficient[Length - Cell_ptr + 1] == 1)
                Y[Cell_ptr] <= Y[Cell_ptr - 1] ^ Y[Length]; // XOR 연산
            else
                Y[Cell_ptr] <= Y[Cell_ptr - 1];            // 단순 이동
        end
        Y[1] <= Y[Length];             // 마지막 비트 순환
    end
end
endmodule
