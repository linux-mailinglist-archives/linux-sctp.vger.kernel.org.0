Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B782356472E
	for <lists+linux-sctp@lfdr.de>; Sun,  3 Jul 2022 13:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiGCLgQ (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sun, 3 Jul 2022 07:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiGCLgP (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sun, 3 Jul 2022 07:36:15 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1167162DF
        for <linux-sctp@vger.kernel.org>; Sun,  3 Jul 2022 04:36:14 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 74EFE5C0079
        for <linux-sctp@vger.kernel.org>; Sun,  3 Jul 2022 07:36:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 03 Jul 2022 07:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        aaronmdjones.net; h=cc:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1656848173; x=1656934573; bh=i6/7Pbn+2J
        4N/whE1V6LCHkQ3QPwoQlcMbCO7bQuQg4=; b=f2UwEspef6YNJdN8Moz2r78jTb
        dldCx4roLI+DJNMSn7sCvPKKWoG7r4bCEME9Jjt3VzUg1kKZYQzyhnV6qJAla1Dl
        jHYK2417YzVsbVZXSxj7E1hEmPp0OogCqRAywuwX3GCdVtUpo57UbTjMPiTdyvXh
        YUiYqupcZVDllhX1QDo8a5+UIiaaZZw0ijTwpnIBlMoQMrlVWaFpDm7cMRRDVuoC
        YrAswpYvvrD+8DTCbLn8c6NiWFHfjsxnAXdvYjjBD8btB/FvgPhFpl3a32OwYQqf
        cs1ZetmWUqAyTVY6XXyGK1dxoT78wKTAC4h+FfcqUP4hhKupmYduUl9tUZtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656848173; x=
        1656934573; bh=i6/7Pbn+2J4N/whE1V6LCHkQ3QPwoQlcMbCO7bQuQg4=; b=D
        4XpUbex2Ue4SzWnEhta6yZ72bV4oZGyNHg/mH8Oqpo91Tgghj5M1P+fSChweNauf
        J23LH6zbP4OoaI1UEWA2XDPvCzilIHAvYYkTC3eNShyigBNtsnmqJ/MdtDrrnx9x
        VoC1ybxJZzeLIUgGVPHU6hHxoP2/OzHOsSVTBfU/DlYKtlpIGFoBoj6U6CbgEGWC
        CUZLNn+VzkDqN/JSmWt34sNI1lYsBz1XdM0rM10SvhZw5N+4gBl1crrW4G3mWxmg
        Q6EHPhvVisfRh5PREAkwIhDa3pk8LRTEGKpotLbAHsVKxV5zcrrAJUJpcFq4T/DR
        npI0u18YcnERKIBaedcpA==
X-ME-Sender: <xms:LX_BYpwX3V4e0XU9IDjJvG-9v6KgF-YDzF0kLxWHCZK1MSbX8zF3zw>
    <xme:LX_BYpRRH1tYacvEUwzDpkTQ23CqE3-ztQKQ1uRwQU_uUPTf9ovz2Y-goWBy5QDtR
    vUDjg5RPbHpNVt54n0>
X-ME-Received: <xmr:LX_BYjUMcXOTf8K83PAwyYfk7H--clAPWAD_oqardhJ2HkZ8gqrbDx3_0MnXNq--cEIf1cGtf0KztP5SFzlEmCpW47I5DyrZ-rB6s8uC8qDkrqVTBuo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehjedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoufhushhpvggtthffohhmrghinhculdegledmne
    cujfgurheptgfkffggfgfvhffusehmtderredtfeejnecuhfhrohhmpeetrghrohhnucfl
    ohhnvghsuceomhgvsegrrghrohhnmhgujhhonhgvshdrnhgvtheqnecuggftrfgrthhtvg
    hrnhepgfekudfhudevkedvkeekgfehfefhjeevieekudejgeffgfeffefhveeggfelkeel
    necuffhomhgrihhnpeguvggsihgrnhdrnhgvthdpihhmghhurhdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvgesrggrrhhonhhm
    ughjohhnvghsrdhnvght
X-ME-Proxy: <xmx:LX_BYrg82TNBirPG7i90zNlfZVJmpKlIBtjGzJqUD9nX6VxpihywCg>
    <xmx:LX_BYrDu7wWjvSeFvv0p3KaxyyVes9hpVNPL3YGN-OlDWmfzDdBGXg>
    <xmx:LX_BYkJdwUIFI_fOF6-1pGTuvrbQBWUjtPw4dnSEv5f3Bp3qdx9L-A>
    <xmx:LX_BYu-i3FiOBOw5SUUaHQC_SfI6MBYuMnDsdm9BNjF99Lk58tg0IQ>
Feedback-ID: idff947e1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <linux-sctp@vger.kernel.org>; Sun, 3 Jul 2022 07:36:12 -0400 (EDT)
Content-Type: multipart/mixed; boundary="------------drwzVA6fZyFfSaz5H8LvWVSb"
Message-ID: <7e246db6-c78e-4d13-4a38-002ac64e3b41@aaronmdjones.net>
Date:   Sun, 3 Jul 2022 11:36:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
To:     linux-sctp@vger.kernel.org
Content-Language: en-GB
From:   Aaron Jones <me@aaronmdjones.net>
Subject: SCTP INIT chunks do not include multi-homing addresses if IPv6 is
 used
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

This is a multi-part message in MIME format.
--------------drwzVA6fZyFfSaz5H8LvWVSb
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

While debugging SCTP multi-homing in an application over the last couple 
of days, I discovered that the cause is because the application randomly 
prefers IPv4 or IPv6 (literally; it does the equivalent of a dice roll).

If the application passes an IPv4 address first to sctp_bindx() and 
sctp_connectx(), followed by an IPv6 address, then multi-homing works; 
the SCTP INIT chunk includes both IP addresses passed to sctp_bindx(), 
and /proc/net/sctp/assocs contains both. Blocking IPv4 traffic does not 
break the connection; it falls back to IPv6.

However, in the reverse situation (IPv6 address followed by an IPv4 
address), it does not; there are no IP addresses in the INIT chunk at 
all. Thus, /proc/net/sctp/assocs contains only IPv6 addresses, and 
blocking IPv6 traffic breaks the connection.

I have written a minimal reproducer at [0] (which I am attaching to this 
message), and you can observe the results at [1] (if you do not wish to 
run it).

I have managed to reproduce it on the following software combinations:

- lksctp-tools 1.0.18 with Linux kernel 5.4 (Linux Mint 20.3)
- lksctp-tools 1.0.19 with Linux kernel 5.10 (Debian 11)
- lksctp-tools 1.0.19 with Linux kernel 4.14.278 (Gentoo)

I do not know whether this is a bug in libsctp or in the kernel.

Regards,
Aaron Jones

[0] <https://paste.debian.net/hidden/998cad29/>
[1] <https://imgur.com/a/qbGrXXV>
--------------drwzVA6fZyFfSaz5H8LvWVSb
Content-Type: text/x-csrc; charset=UTF-8; name="repro.c"
Content-Disposition: attachment; filename="repro.c"
Content-Transfer-Encoding: base64

LyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKICoKICogUmVwcm9kdWNlciBm
b3IgU0NUUCBtdWx0aWhvbWluZyBidWcgd2hlcmUgYW4gSVB2NiBhZGRyZXNzIGdpdmVuIGZp
cnN0CiAqIGluIHRoZSBsaXN0IG9mIGFkZHJlc3NlcyBtZWFucyB0aGF0IHRoZSBTQ1RQIElO
SVQgY2h1bmsgZG9lcyBub3QKICogaW5jbHVkZSBhbnkgSVAgYWRkcmVzc2VzIGFuZCBzbyB0
aGUgYXNzb2NpYXRpb24gZG9lcyBub3QgbXVsdGktaG9tZS4KICoKICogQ29weXJpZ2h0IChD
KSAyMDIyIEFhcm9uIE0uIEQuIEpvbmVzIDxtZUBhYXJvbm1kam9uZXMubmV0PgogKgogKiBn
Y2MgLVdhbGwgLVdleHRyYSAtV3BlZGFudGljIC1zdGQ9Z251OTkgLWxzY3RwIHJlcHJvLmMg
LW8gcmVwcm8KICogLi9yZXBybyA8cG9ydD4gPHJlbW90ZT4gPHJlbW90ZT4gWzxsb2NhbD4g
PGxvY2FsPl0KICovCgojaW5jbHVkZSA8ZXJybm8uaD4KI2luY2x1ZGUgPGludHR5cGVzLmg+
CiNpbmNsdWRlIDxzdGRpbnQuaD4KI2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRs
aWIuaD4KI2luY2x1ZGUgPHN0cmluZy5oPgojaW5jbHVkZSA8dW5pc3RkLmg+CgojaW5jbHVk
ZSA8YXJwYS9pbmV0Lmg+CiNpbmNsdWRlIDxuZXRpbmV0L2luLmg+CiNpbmNsdWRlIDxuZXRp
bmV0L3NjdHAuaD4KCmludAptYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCnsKCXN0cnVj
dCBzb2NrYWRkcl9zdG9yYWdlIHNzOwoJc3RydWN0IHNvY2thZGRyX2luICpzYTQgPSAoc3Ry
dWN0IHNvY2thZGRyX2luICopICZzczsKCXN0cnVjdCBzb2NrYWRkcl9pbjYgKnNhNiA9IChz
dHJ1Y3Qgc29ja2FkZHJfaW42ICopICZzczsKCXVpbnQ4X3QgbGFkZHJzW3NpemVvZihzdHJ1
Y3Qgc29ja2FkZHJfc3RvcmFnZSkgKiAyXTsKCXVpbnQ4X3QgcmFkZHJzW3NpemVvZihzdHJ1
Y3Qgc29ja2FkZHJfc3RvcmFnZSkgKiAyXTsKCXVpbnQ4X3QgKmxhZGRycCA9IGxhZGRyczsK
CXVpbnQ4X3QgKnJhZGRycCA9IHJhZGRyczsKCXVpbnQxNl90IHBvcnQgPSAwOwoKCW1lbXNl
dChsYWRkcnMsIDB4MDAsIHNpemVvZiBsYWRkcnMpOwoJbWVtc2V0KHJhZGRycywgMHgwMCwg
c2l6ZW9mIHJhZGRycyk7CgoJY29uc3QgaW50IGZkID0gc29ja2V0KEFGX0lORVQ2LCBTT0NL
X1NUUkVBTSwgSVBQUk9UT19TQ1RQKTsKCglpZiAoZmQgPT0gLTEpCgl7CgkJcGVycm9yKCJz
b2NrZXQiKTsKCQlyZXR1cm4gRVhJVF9GQUlMVVJFOwoJfQoJaWYgKGFyZ2MgPCA0IHx8IGFy
Z2MgPT0gNSB8fCBhcmdjID4gNikKCXsKCQlmcHJpbnRmKHN0ZGVyciwgIlVzYWdlOiAuL3Jl
cHJvIDxwb3J0PiA8cmVtb3RlPiA8cmVtb3RlPiBbPGxvY2FsPiA8bG9jYWw+XVxuIik7CgkJ
cmV0dXJuIEVYSVRfRkFJTFVSRTsKCX0KCWlmIChzc2NhbmYoYXJndlsxXSwgIiUiIFNDTnUx
NiwgJnBvcnQpICE9IDEgfHwgcG9ydCA9PSAwKQoJewoJCWZwcmludGYoc3RkZXJyLCAiSW52
YWxpZCBwb3J0IFwiJXNcIlxuIiwgYXJndlsxXSk7CgkJcmV0dXJuIEVYSVRfRkFJTFVSRTsK
CX0KCWZvciAoaW50IGkgPSAyOyBpIDwgNDsgaSsrKQoJewoJCW1lbXNldCgmc3MsIDB4MDAs
IHNpemVvZiBzcyk7CgoJCWlmIChpbmV0X3B0b24oQUZfSU5FVCwgYXJndltpXSwgJnNhNC0+
c2luX2FkZHIpID09IDEpCgkJewoJCQlzYTQtPnNpbl9mYW1pbHkgPSBBRl9JTkVUOwoJCQlz
YTQtPnNpbl9wb3J0ID0gaHRvbnMocG9ydCk7CgkJCW1lbWNweShyYWRkcnAsIHNhNCwgc2l6
ZW9mICpzYTQpOwoJCQlyYWRkcnAgKz0gc2l6ZW9mICpzYTQ7CgkJfQoJCWVsc2UgaWYgKGlu
ZXRfcHRvbihBRl9JTkVUNiwgYXJndltpXSwgJnNhNi0+c2luNl9hZGRyKSA9PSAxKQoJCXsK
CQkJc2E2LT5zaW42X2ZhbWlseSA9IEFGX0lORVQ2OwoJCQlzYTYtPnNpbjZfcG9ydCA9IGh0
b25zKHBvcnQpOwoJCQltZW1jcHkocmFkZHJwLCBzYTYsIHNpemVvZiAqc2E2KTsKCQkJcmFk
ZHJwICs9IHNpemVvZiAqc2E2OwoJCX0KCQllbHNlCgkJewoJCQlmcHJpbnRmKHN0ZGVyciwg
IkludmFsaWQgSVAgYWRkcmVzcyBcIiVzXCJcbiIsIGFyZ3ZbaV0pOwoJCQlyZXR1cm4gRVhJ
VF9GQUlMVVJFOwoJCX0KCX0KCWZvciAoaW50IGkgPSA0OyBpIDwgYXJnYzsgaSsrKQoJewoJ
CW1lbXNldCgmc3MsIDB4MDAsIHNpemVvZiBzcyk7CgoJCWlmIChpbmV0X3B0b24oQUZfSU5F
VCwgYXJndltpXSwgJnNhNC0+c2luX2FkZHIpID09IDEpCgkJewoJCQlzYTQtPnNpbl9mYW1p
bHkgPSBBRl9JTkVUOwoJCQlzYTQtPnNpbl9wb3J0ID0gaHRvbnMocG9ydCk7CgkJCW1lbWNw
eShsYWRkcnAsIHNhNCwgc2l6ZW9mICpzYTQpOwoJCQlsYWRkcnAgKz0gc2l6ZW9mICpzYTQ7
CgkJfQoJCWVsc2UgaWYgKGluZXRfcHRvbihBRl9JTkVUNiwgYXJndltpXSwgJnNhNi0+c2lu
Nl9hZGRyKSA9PSAxKQoJCXsKCQkJc2E2LT5zaW42X2ZhbWlseSA9IEFGX0lORVQ2OwoJCQlz
YTYtPnNpbjZfcG9ydCA9IGh0b25zKHBvcnQpOwoJCQltZW1jcHkobGFkZHJwLCBzYTYsIHNp
emVvZiAqc2E2KTsKCQkJbGFkZHJwICs9IHNpemVvZiAqc2E2OwoJCX0KCQllbHNlCgkJewoJ
CQlmcHJpbnRmKHN0ZGVyciwgIkludmFsaWQgSVAgYWRkcmVzcyBcIiVzXCJcbiIsIGFyZ3Zb
aV0pOwoJCQlyZXR1cm4gRVhJVF9GQUlMVVJFOwoJCX0KCX0KCWlmIChhcmdjID09IDYgJiYg
c2N0cF9iaW5keChmZCwgKHN0cnVjdCBzb2NrYWRkciAqKSBsYWRkcnMsIDIsIFNDVFBfQklO
RFhfQUREX0FERFIpID09IC0xKQoJewoJCXBlcnJvcigic2N0cF9iaW5keCIpOwoJCXJldHVy
biBFWElUX0ZBSUxVUkU7Cgl9CglpZiAoc2N0cF9jb25uZWN0eChmZCwgKHN0cnVjdCBzb2Nr
YWRkciAqKSByYWRkcnMsIDIsIE5VTEwpID09IC0xKQoJewoJCXBlcnJvcigic2N0cF9jb25u
ZWN0eCIpOwoJCXJldHVybiBFWElUX0ZBSUxVUkU7Cgl9CgoJY2xvc2UoZmQpOwoKCXJldHVy
biBFWElUX1NVQ0NFU1M7Cn0K

--------------drwzVA6fZyFfSaz5H8LvWVSb--
