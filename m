Return-Path: <linux-sctp+bounces-590-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB37B0E458
	for <lists+linux-sctp@lfdr.de>; Tue, 22 Jul 2025 21:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDB1C1C27E7E
	for <lists+linux-sctp@lfdr.de>; Tue, 22 Jul 2025 19:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F39027E7DA;
	Tue, 22 Jul 2025 19:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaU+yiWu"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B0D27F171;
	Tue, 22 Jul 2025 19:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753213634; cv=none; b=tYUJNCekLEidiNlkHg/gBDXZS80m3K6gpLjJva9eoQrvBAMN7AC99n3HPvu4dsZlyEo9hkusavK7ZEyq0YP3wkWYPCmjz+t+xqj4dbNX2iYyez72N3BqLLsezvATxx2ufrs/qhTcx+3cyUpBiBkZxkYJHG/29II6rzvBQxn3JHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753213634; c=relaxed/simple;
	bh=iO7d/K/ByA2zX5IPUfWfWoEwkjQxJdMK97xQSKEP1No=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Ja/UT9zM0Jjn9yrmauz47BOMYYRuCBLvoju7AzAQMnXQT2DNU1zFj8NDAWw9YOepVQTTWGQhwcGqmRgzhTlRx/NzUc2IbC4PpFQZcPfXHRwHXVfdC24u2GdlHnLCLSdn/HE3iPeJFM4m81vvKUJRegrHOR8USuYjJX1t/OCpf+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaU+yiWu; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e8dbe824ee8so813513276.3;
        Tue, 22 Jul 2025 12:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753213631; x=1753818431; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G3CnhSPhz6dfPPFuvd9/j/cIrng1PpfxtkNsI5eLF9U=;
        b=PaU+yiWuxTwDi904eap7/9ZVFlp1UD3k0lVypxWRcz+B/Q0QGTvrFDaM8zbkVMBtHu
         nOIWxRir4lb2s7FKhxaCikOSsFJof//cNBQFDeGZ4GEEXwU83uGQWwwDD2Uiz0GlSJZu
         jv6tiIg3IAe8TrmViPi5vP0hYff25pi5AHAy7Ed8a3LVQ4d1PMCktpmCjh5zRk67YYTI
         JkLc+urSrrKjnEu70ztRI3NQw+kn8O7MHRGmXJNneNH6vkBSn3uHGRsAizp+5+ths224
         zwRBgqUYzx67KfwuE5j7O2l3hfKtw4kuPPV99WIzF1UOXfYmIIpXfLOU+MD3uegdwE6b
         Nh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753213631; x=1753818431;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G3CnhSPhz6dfPPFuvd9/j/cIrng1PpfxtkNsI5eLF9U=;
        b=fqvAK9/xGkLua/KKx1YPt4+s5ralMMRJXh8vZ2mW04XWwAg8mUf+ycCM+TTqKd4i5H
         BgQeg0WRncWez5gHLLtOrtMmKPZrEAlZu1amhAJ/foASvJIh5jVm907xIt32LlCeK5Pc
         o86sn2K8t0yg6P6cHUVikBFp2GmUk6XxuyuTPpF6umw8RuEw7bIVx7zUqpq7xzKNr3VA
         2tQOgx5ExAT3xtE+x704NzKtG2MO1CGeUijlz+gkV6uU9eEgwcPvl4tMhRtKyBiUyTUh
         XLSaGt3fRbSHrjrRr1mVOI6kOgv2E3wwMIU+Cwg1hnqE3A6nNSDRHY2H9K1ff/VCSKOv
         knOA==
X-Forwarded-Encrypted: i=1; AJvYcCVAWH8zFSTYeAJd0Wf/mAKl5fSnLJ4Bt4K4ulQC3TrKOLNkmGvHuSQSdo9vibZ1q+I6HYUL4+8I07MugA==@vger.kernel.org, AJvYcCVdoT485enk/nWOtLewi1IE8NmAFchr77aOj5BbsMY9nKaxeTbH5Y9BkGunnrDDByhTTDi5aZ7O/kWOh4E=@vger.kernel.org, AJvYcCXnJ3QvlY1djjA8b5n40sY3nIgV3RY8CynN8kxvBjMMhE9Z10AApH3KkSTJ+CXScNe1oeoBTP9J@vger.kernel.org
X-Gm-Message-State: AOJu0YzJAYw+1/+GHj1aQ4KCdnKXgPxZMM2nB/Lp19tuJI/zF4WhnUH2
	Dz1Mi/0PtkmNWpSOVmPL2IU9OVcDwzNh//+IlV27HKHaEods3myGOJhR/4HzCkRfKOXLqGmqjqr
	pybTnh+F7uzQUrENFADr6CRR+AOvS4vbJ3F6e
X-Gm-Gg: ASbGnctxY0Umtt89jQEfUhFG0GP3sw558njV+znslFPxmtHNDoGyxN4SA/FJN21lfLm
	oVHx6jit4BMVxB3hbCep1Ci0SuYeueUa/O7laSMZ0CJ/7z0plzNetrcvDIuNy9vEtT9H+cxK732
	JhZTC6EuzRYrbQ7/37YeMVasr6sz970iG9qYJl05FCWXEK989cfEpx6sEPniBd1QWgFBfxceuac
	jbpW9Xa
X-Google-Smtp-Source: AGHT+IEVmFI0s4UQ4s2k16dnoFchJnzrkcOtrKGi+3Zk06o16XMJcBgq0q80beO8iKtSFP9244VnISXPDS2GfyIV80w=
X-Received: by 2002:a05:6902:2388:b0:e84:1f2f:c4b6 with SMTP id
 3f1490d57ef6-e8dc58ce284mr773868276.10.1753213631193; Tue, 22 Jul 2025
 12:47:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Moon Hee Lee <moonhee.lee.ca@gmail.com>
Date: Tue, 22 Jul 2025 12:46:59 -0700
X-Gm-Features: Ac12FXzvIaNuC3SnSgjKPlx4aLG5P7dT5sS7al4pzn0RQZ6-QUdkYCBgzvTcO_A
Message-ID: <CAF3JpA5JPbEByou1OKfuPMKH1o--0q113pNoPyPR-h3QjuZxUg@mail.gmail.com>
Subject: [syzbot] [sctp?] UBSAN: shift-out-of-bounds in sctp_transport_update_rto
To: syzbot+2e455dd90ca648e48cea@syzkaller.appspotmail.com
Cc: syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000b423ad063a89db26"

--000000000000b423ad063a89db26
Content-Type: text/plain; charset="UTF-8"

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git main

--000000000000b423ad063a89db26
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-sctp-guard-rto_alpha-and-rto_beta-against-unsafe-shi.patch"
Content-Disposition: attachment; 
	filename="0001-sctp-guard-rto_alpha-and-rto_beta-against-unsafe-shi.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mdexz0kx0>
X-Attachment-Id: f_mdexz0kx0

RnJvbSA3YzQ3MmI0MGI5MDFhMTJjZmM4ZGMwMGNhMGE5OWFjMmQ5OTJjMzM4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNb29uIEhlZSBMZWUgPG1vb25oZWUubGVlLmNhQGdtYWlsLmNv
bT4KRGF0ZTogVHVlLCAyMiBKdWwgMjAyNSAxMjozMToxNiAtMDcwMApTdWJqZWN0OiBbUEFUQ0gg
bmV0XSBzY3RwOiBndWFyZCBydG9fYWxwaGEgYW5kIHJ0b19iZXRhIGFnYWluc3QgdW5zYWZlIHNo
aWZ0CiB2YWx1ZXMKCnJ0b19hbHBoYSBhbmQgcnRvX2JldGEgYXJlIHVzZWQgYXMgc2hpZnQgYW1v
dW50cyBpbiB0aGUgUlRUIHNtb290aGluZwpjYWxjdWxhdGlvbiwgd2hlcmUgdGhleSByZXByZXNl
bnQgaW52ZXJzZSBwb3dlcnMgb2YgdHdvIChlLmcuIDMgbWVhbnMgMS84KS4KCkN1cnJlbnRseSwg
dGhlIGNvZGUgdXNlcyBuZXQtPnNjdHAucnRvX2FscGhhIGFuZCBydG9fYmV0YSBkaXJlY3RseSBp
biBzaGlmdApleHByZXNzaW9ucyB3aXRob3V0IHZhbGlkYXRpbmcgdGhlbS4gSWYgdXNlci1jb250
cm9sbGVkIG9yIGNvcnJ1cHRlZCB2YWx1ZXMKZXhjZWVkIHZhbGlkIHNoaWZ0IGJvdW5kcyBmb3Ig
MzItYml0IGludGVnZXJzIChlLmcuIDIzNyksIHRoaXMgbGVhZHMgdG8KdW5kZWZpbmVkIGJlaGF2
aW9yIGFuZCBydW50aW1lIGZhdWx0cy4KCnN5emJvdCByZXBvcnRlZCBzdWNoIGEgY2FzZSB2aWEg
VUJTQU46CgogIFVCU0FOOiBzaGlmdC1vdXQtb2YtYm91bmRzIGluIG5ldC9zY3RwL3RyYW5zcG9y
dC5jOjUwOTo0MQogIHNoaWZ0IGV4cG9uZW50IDIzNyBpcyB0b28gbGFyZ2UgZm9yIDMyLWJpdCB0
eXBlICd1bnNpZ25lZCBpbnQnCgpUaGlzIHBhdGNoIGVuc3VyZXMgYm90aCB2YWx1ZXMgYXJlIHdp
dGhpbiB0aGUgc2FmZSBzaGlmdCByYW5nZSBbMCwgMzFdLgpJZiBub3QsIHRoZSBjb2RlIGZhbGxz
IGJhY2sgdG8gdGhlIGRlZmF1bHQgY29uc3RhbnRzIFNDVFBfUlRPX0FMUEhBIGFuZApTQ1RQX1JU
T19CRVRBIHRvIGVuc3VyZSBjb3JyZWN0bmVzcyBhbmQgc3lzdGVtIHN0YWJpbGl0eS4KClRoaXMg
cHJlc2VydmVzIFNDVFAgdHVuYWJpbGl0eSB3aGlsZSBwcmV2ZW50aW5nIHVuZGVmaW5lZCBiZWhh
dmlvci4KClNpZ25lZC1vZmYtYnk6IE1vb24gSGVlIExlZSA8bW9vbmhlZS5sZWUuY2FAZ21haWwu
Y29tPgotLS0KIG5ldC9zY3RwL3RyYW5zcG9ydC5jIHwgMTEgKysrKysrKysrKysKIDEgZmlsZSBj
aGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvbmV0L3NjdHAvdHJhbnNwb3J0
LmMgYi9uZXQvc2N0cC90cmFuc3BvcnQuYwppbmRleCA2OTQ2YzE0NjI3OTMuLjg0ODMxMWJiN2E5
ZiAxMDA2NDQKLS0tIGEvbmV0L3NjdHAvdHJhbnNwb3J0LmMKKysrIGIvbmV0L3NjdHAvdHJhbnNw
b3J0LmMKQEAgLTQ5NSw2ICs0OTUsOCBAQCB2b2lkIHNjdHBfdHJhbnNwb3J0X3VwZGF0ZV9ydG8o
c3RydWN0IHNjdHBfdHJhbnNwb3J0ICp0cCwgX191MzIgcnR0KQogCiAJaWYgKHRwLT5ydHR2YXIg
fHwgdHAtPnNydHQpIHsKIAkJc3RydWN0IG5ldCAqbmV0ID0gdHAtPmFzb2MtPmJhc2UubmV0Owor
CQlpbnQgcnRvX2FscGhhID0gbmV0LT5zY3RwLnJ0b19hbHBoYTsKKwkJaW50IHJ0b19iZXRhID0g
bmV0LT5zY3RwLnJ0b19iZXRhOwogCQkvKiA2LjMuMSBDMykgV2hlbiBhIG5ldyBSVFQgbWVhc3Vy
ZW1lbnQgUicgaXMgbWFkZSwgc2V0CiAJCSAqIFJUVFZBUiA8LSAoMSAtIFJUTy5CZXRhKSAqIFJU
VFZBUiArIFJUTy5CZXRhICogfFNSVFQgLSBSJ3wKIAkJICogU1JUVCA8LSAoMSAtIFJUTy5BbHBo
YSkgKiBTUlRUICsgUlRPLkFscGhhICogUicKQEAgLTUwNSw3ICs1MDcsMTYgQEAgdm9pZCBzY3Rw
X3RyYW5zcG9ydF91cGRhdGVfcnRvKHN0cnVjdCBzY3RwX3RyYW5zcG9ydCAqdHAsIF9fdTMyIHJ0
dCkKIAkJICogb2YgdHdvLgogCQkgKiBGb3IgZXhhbXBsZSwgYXNzdW1pbmcgdGhlIGRlZmF1bHQg
dmFsdWUgb2YgUlRPLkFscGhhIG9mCiAJCSAqIDEvOCwgcnRvX2FscGhhIHdvdWxkIGJlIGV4cHJl
c3NlZCBhcyAzLgorCQkgKgorCQkgKiBHdWFyZCBydG9fYWxwaGEgYW5kIHJ0b19iZXRhIHRvIGVu
c3VyZSB0aGV5IGFyZSB3aXRoaW4KKwkJICogdmFsaWQgc2hpZnQgYm91bmRzIFswLCAzMV0gdG8g
YXZvaWQgdW5kZWZpbmVkIGJlaGF2aW9yLgogCQkgKi8KKwkJaWYgKHVubGlrZWx5KHJ0b19hbHBo
YSA8IDAgfHwgcnRvX2FscGhhID49IDMyKSkKKwkJCXJ0b19hbHBoYSA9IFNDVFBfUlRPX0FMUEhB
OworCisJCWlmICh1bmxpa2VseShydG9fYmV0YSA8IDAgfHwgcnRvX2JldGEgPj0gMzIpKQorCQkJ
cnRvX2JldGEgPSBTQ1RQX1JUT19CRVRBOworCiAJCXRwLT5ydHR2YXIgPSB0cC0+cnR0dmFyIC0g
KHRwLT5ydHR2YXIgPj4gbmV0LT5zY3RwLnJ0b19iZXRhKQogCQkJKyAoKChfX3UzMilhYnMoKF9f
czY0KXRwLT5zcnR0IC0gKF9fczY0KXJ0dCkpID4+IG5ldC0+c2N0cC5ydG9fYmV0YSk7CiAJCXRw
LT5zcnR0ID0gdHAtPnNydHQgLSAodHAtPnNydHQgPj4gbmV0LT5zY3RwLnJ0b19hbHBoYSkKLS0g
CjIuNDMuMAoK
--000000000000b423ad063a89db26--

