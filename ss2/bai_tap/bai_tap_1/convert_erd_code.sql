create database ss2_relational_model;
use ss2_relational_model;
CREATE TABLE phieu_xuat (
    so_px INT AUTO_INCREMENT PRIMARY KEY,
    ngay_xuat DATE
);
CREATE TABLE vat_tu (
    ma_vtu INT AUTO_INCREMENT PRIMARY KEY,
    ten_vtu VARCHAR(50)
);
CREATE TABLE chi_tiet_phieu_xuat (
    so_px INT,
    ma_vtu INT,
    dg_xuat DOUBLE,
    sl_xuat INT,
    PRIMARY KEY (so_px , ma_vtu),
    FOREIGN KEY (so_px)
        REFERENCES phieu_xuat (so_px),
    FOREIGN KEY (ma_vtu)
        REFERENCES vat_tu (ma_vtu)
);
CREATE TABLE phieu_nhap (
    so_pn INT AUTO_INCREMENT PRIMARY KEY,
    ngay_nhap DATE
);
CREATE TABLE chi_tiet_phieu_nhap (
    ma_vtu INT,
    so_pn INT,
    dg_nhap DOUBLE,
    sl_nhap INT,
    PRIMARY KEY (ma_vtu , so_pn),
    FOREIGN KEY (ma_vtu)
        REFERENCES vat_tu (ma_vtu),
    FOREIGN KEY (so_pn)
        REFERENCES phieu_nhap (so_pn)
);
CREATE TABLE nha_cung_cap (
    ma_ncc INT AUTO_INCREMENT PRIMARY KEY,
    ten_ncc VARCHAR(50),
    dia_chi VARCHAR(50)
);
CREATE TABLE don_dat_hang (
    so_dh INT AUTO_INCREMENT PRIMARY KEY,
    ngay_dh VARCHAR(50),
    ma_ncc INT,
    FOREIGN KEY (ma_ncc)
        REFERENCES nha_cung_cap (ma_ncc)
);
CREATE TABLE chi_tiet_dat_hang (
    ma_vtu INT,
    so_dh INT,
    PRIMARY KEY (ma_vtu , so_dh),
    FOREIGN KEY (ma_vtu)
        REFERENCES vat_tu (ma_vtu),
    FOREIGN KEY (so_dh)
        REFERENCES don_dat_hang (so_dh)
);
CREATE TABLE so_dien_thoai (
    so_dien_thoai INT PRIMARY KEY,
    ma_ncc INT,
    FOREIGN KEY (ma_ncc)
        REFERENCES nha_cung_cap (ma_ncc)
);



