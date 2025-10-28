Return-Path: <linux-sctp+bounces-716-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 080A3C14446
	for <lists+linux-sctp@lfdr.de>; Tue, 28 Oct 2025 12:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 255BF1881782
	for <lists+linux-sctp@lfdr.de>; Tue, 28 Oct 2025 11:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1C525486D;
	Tue, 28 Oct 2025 11:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yI3J4puU"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D4D22D7A5
	for <linux-sctp@vger.kernel.org>; Tue, 28 Oct 2025 11:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761649371; cv=none; b=dtnmEBwGc7YzQ1MPlvpqW9IUtX0X8xvqLliiAU5Ouull3Gkd81ImFKrenO51xV2MVFHJW9Z0LJE8rnEpzf8B5DAgHjLcvA3ck3CPFXFopWottbRI9u8PaCGFD8zBokBpbDc48RSewuZuPHo+nr/v6HI2rCX+ZKs5yVgrolnMAfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761649371; c=relaxed/simple;
	bh=rbbNs8bAn2H/pli/q3/VuZMZTWvda+Xmk6LRpVtTPlk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Jg8U+DpzYADuZlriVVEY4Zx0MMHCM5v2b1UoLeZgd4DQJiZHOcidYYWBRwJ9dOSA0mOlZmcP2sAaUWZVdliVRe1Ov5/TMvEI0YNT1PIic8ZVQ0/Z+KVitlZJLaZM1Rs7oOynzhw2hMOLPKQdVIOc4ZqATgNiI+gVqU5IVuhaFf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yI3J4puU; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47114a40161so65795585e9.3
        for <linux-sctp@vger.kernel.org>; Tue, 28 Oct 2025 04:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761649368; x=1762254168; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=POfqSkjbtDhnBAiu6383s4qahBcnRhhAunxgmMUAWic=;
        b=yI3J4puUSW5M7jsbKoa+DXpaD9jb2RRvNLmyryq/zfPljMHmhqGWJpzJWpUus7Las0
         yjhrlH8mg6+g8u06KyOjUvnVDnJXrqVmqqlzTtBTUyS7CF1Ve4JqQRbvly36qKgVBFlz
         v2rbjHHldQLw16iguEynnQxHUfl/gqUaW3nWNEDO30MnN6FF8NHgboEyYpEShzyvCOX+
         vxIFuM5jNbz0VFsh5IjwRkuZcSWUTH9zKSVn/j6WwyGF8G4qS/2HT0bIh1eO/DHRKkeo
         nkbSnG8bFj81ohsmf/jMn3ISde0/at5Mj2zsDW5J1z7QnYG1qHnegPS8A3gYzNf6Wgie
         iR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761649368; x=1762254168;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=POfqSkjbtDhnBAiu6383s4qahBcnRhhAunxgmMUAWic=;
        b=r5WcgJcCjq3jhSs3xiV3iCNhW37bBLhukRCL9+uddsAb1d0SMe8huUy/AssL2fwF8Q
         npx7Xn2Bj7noc2/vzhd+/KGF/viU8IBBvlAKDPJOXuZEwcBhnft6iGMmnG6IliO/2BRM
         9+hZ7NdJi5oyDkyq3e1C8VaEGbuyKci09sHGWiyH1GQ+iankqzfpP2YcGnBRjllPeMUp
         eUeiojmZLTnZLQdePLnJjE1/YJ/NfSONR9r3PBjxsSYKhN4hJC34J/pTT0IFxfrYefLw
         jiaUbaxkC3yGwCvWD65iH36KpKKyhNReZaeTP6LdGm53IGt65Cf7WdOxwDEtM7Z+yk94
         4VDw==
X-Gm-Message-State: AOJu0Yz4JJSiZn2D9cfYKy1KJua5EcjMEpXFxjbd5Kffa8TPnbB+e5d+
	vnDzSTnz8qejL/QTqNZdzaiXITSHgA1Wc5acwZwzsRjEZXDq79LTGzARWRvYPjDN1nZpG9MUkod
	JNVZl
X-Gm-Gg: ASbGncsV7MLm0wo1nNuJMnp9R9vVcO2g2DK3WrAeFOj+kKPIxbjBLCgGoHyWf7krky7
	0whDJJQh8OGdqDJbOwpJmjVLQ+NfxlGvzEUgI7SrrlSB4tgsIEv7CKKUNM+WIQ7AVCsI6e3QDQo
	N1Y++t80bBaqSVHkE0NRDrDIeKpLQiETBfsp2SewPiLyRGvh8cYBdUW39vmhnE0pxzxc3nSq+jh
	pH3kcHMYuMvV4GfhRUXz2L/jjugcUuZT4Z+N2MJEpgIsiylbUKdM1/7HNP+0NSTMjcl/DD84NcK
	/ZKMZZAc8HOYLmD4Uahn7E/jkITG8IXplqwx/PQuo5TKLnPJxKYvlnd0bDRwl7lN9O8DwvdUY6o
	FOoclnbj+cuG0MpEL7a37IPjViSkidpu5qsyqEmnpWr4DomgYuB7etuoRGY99pmPAQsKWibJGsw
	M4M96FEw==
X-Google-Smtp-Source: AGHT+IHmpGj+BiLeJGbJO0RtO8hUeJ3Zdalc++dsKhWEWO4FMPk8iquoKzvL33W7TRVHEA0OALw5qQ==
X-Received: by 2002:a05:600c:3511:b0:476:84e9:b561 with SMTP id 5b1f17b1804b1-47717e587d1mr31174045e9.32.1761649367897;
        Tue, 28 Oct 2025 04:02:47 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-475dd4a6043sm189408465e9.12.2025.10.28.04.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 04:02:47 -0700 (PDT)
Date: Tue, 28 Oct 2025 14:02:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kees Cook <kees@kernel.org>
Cc: linux-sctp@vger.kernel.org
Subject: [bug report] sctp: Replace sockaddr with sockaddr_inet in sctp_addr
 union
Message-ID: <aQCi09SH9OJtgkXc@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Kees Cook,

Commit 511d10b4c2f9 ("sctp: Replace sockaddr with sockaddr_inet in
sctp_addr union") from Jul 22, 2025 (linux-next), leads to the
following Smatch static checker warnings:

net/sctp/socket.c:396 sctp_do_bind() error: '%pIS' expects argument of type struct sockaddr *, argument 5 has type 'struct sockaddr_inet*'
net/sctp/socket.c:851 sctp_send_asconf_del_ip() error: '%pIS' expects argument of type struct sockaddr *, argument 5 has type 'struct sockaddr_inet*'
net/sctp/protocol.c:642 sctp_addr_wq_timeout_handler() error: '%pIS' expects argument of type struct sockaddr *, argument 5 has type 'struct sockaddr_inet*'
net/sctp/protocol.c:761 sctp_addr_wq_mgmt() error: '%pIS' expects argument of type struct sockaddr *, argument 5 has type 'struct sockaddr_inet*'
net/sctp/protocol.c:781 sctp_addr_wq_mgmt() error: '%pIS' expects argument of type struct sockaddr *, argument 5 has type 'struct sockaddr_inet*'
net/sctp/sm_sideeffect.c:602 sctp_do_8_2_transport_strike() error: '%pIS' expects argument of type struct sockaddr *, argument 5 has type 'struct sockaddr_inet*'
net/sctp/associola.c:489 sctp_assoc_rm_peer() error: '%pIS' expects argument of type struct sockaddr *, argument 5 has type 'struct sockaddr_inet*'
net/sctp/associola.c:597 sctp_assoc_add_peer() error: '%pIS' expects argument of type struct sockaddr *, argument 5 has type 'struct sockaddr_inet*'
net/sctp/associola.c:1291 sctp_assoc_update_retran_path() error: '%pIS' expects argument of type struct sockaddr *, argument 5 has type 'struct sockaddr_inet*'
drivers/net/wireguard/socket.c:76 send4() error: '%pIS' expects argument of type struct sockaddr *, argument 4 has type 'struct sockaddr_inet*'
drivers/net/wireguard/socket.c:143 send6() error: '%pIS' expects argument of type struct sockaddr *, argument 4 has type 'struct sockaddr_inet*'
drivers/net/wireguard/peer.c:204 kref_release() error: '%pIS' expects argument of type struct sockaddr *, argument 5 has type 'struct sockaddr_inet*'
drivers/net/wireguard/timers.c:47 wg_expired_retransmit_handshake() error: '%pIS' expects argument of type struct sockaddr *, argument 5 has type 'struct sockaddr_inet*'
drivers/net/wireguard/timers.c:65 wg_expired_retransmit_handshake() error: '%pIS' expects argument of type struct sockaddr *, argument 5 has type 'struct sockaddr_inet*'
drivers/net/wireguard/timers.c:97 wg_expired_new_handshake() error: '%pIS' expects argument of type struct sockaddr *, argument 5 has type 'struct sockaddr_inet*'
drivers/net/wireguard/timers.c:130 wg_queued_expired_zero_key_material() error: '%pIS' expects argument of type struct sockaddr *, argument 5 has type 'struct sockaddr_inet*'
drivers/net/wireguard/send.c:30 wg_packet_send_handshake_initiation() error: '%pIS' expects argument of type struct sockaddr *, argument 5 has type 'struct sockaddr_inet*'
drivers/net/wireguard/send.c:90 wg_packet_send_handshake_response() error: '%pIS' expects argument of type struct sockaddr *, argument 5 has type 'struct sockaddr_inet*'
drivers/net/wireguard/send.c:116 wg_packet_send_handshake_cookie() error: '%pIS' expects argument of type struct sockaddr *, argument 4 has type 'struct sockaddr_inet*'
drivers/net/wireguard/send.c:234 wg_packet_send_keepalive() error: '%pIS' expects argument of type struct sockaddr *, argument 5 has type 'struct sockaddr_inet*'
drivers/net/wireguard/receive.c:105 wg_receive_handshake_packet() error: '%pIS' expects argument of type struct sockaddr *, argument 4 has type 'struct sockaddr_inet*'
drivers/net/wireguard/receive.c:129 wg_receive_handshake_packet() error: '%pIS' expects argument of type struct sockaddr *, argument 4 has type 'struct sockaddr_inet*'
drivers/net/wireguard/receive.c:146 wg_receive_handshake_packet() error: '%pIS' expects argument of type struct sockaddr *, argument 4 has type 'struct sockaddr_inet*'
drivers/net/wireguard/receive.c:151 wg_receive_handshake_packet() error: '%pIS' expects argument of type struct sockaddr *, argument 5 has type 'struct sockaddr_inet*'
drivers/net/wireguard/receive.c:168 wg_receive_handshake_packet() error: '%pIS' expects argument of type struct sockaddr *, argument 4 has type 'struct sockaddr_inet*'
drivers/net/wireguard/receive.c:173 wg_receive_handshake_packet() error: '%pIS' expects argument of type struct sockaddr *, argument 5 has type 'struct sockaddr_inet*'
drivers/net/wireguard/receive.c:359 wg_packet_consume_data_done() error: '%pIS' expects argument of type struct sockaddr *, argument 5 has type 'struct sockaddr_inet*'
drivers/net/wireguard/receive.c:416 wg_packet_consume_data_done() error: '%pIS' expects argument of type struct sockaddr *, argument 4 has type 'struct sockaddr_inet*'
drivers/net/wireguard/receive.c:416 wg_packet_consume_data_done() error: '%pIS' expects argument of type struct sockaddr *, argument 6 has type 'struct sockaddr_inet*'
drivers/net/wireguard/receive.c:423 wg_packet_consume_data_done() error: '%pIS' expects argument of type struct sockaddr *, argument 5 has type 'struct sockaddr_inet*'
drivers/net/wireguard/receive.c:429 wg_packet_consume_data_done() error: '%pIS' expects argument of type struct sockaddr *, argument 5 has type 'struct sockaddr_inet*'
drivers/net/wireguard/receive.c:563 wg_packet_receive() error: '%pIS' expects argument of type struct sockaddr *, argument 4 has type 'struct sockaddr_inet*'

net/sctp/socket.c
    850 
--> 851                         pr_debug("%s: keep the last address asoc:%p %pISc at %p\n",
    852                                  __func__, asoc, &asoc->asconf_addr_del_pending->sa,
    853                                  asoc->asconf_addr_del_pending);
    854 

The "asoc->asconf_addr_del_pending" variable is a sctp_addr union defined
like this.

include/net/sctp/structs.h
    51  /* A convenience structure for handling sockaddr structures.
    52   * We should wean ourselves off this.
    53   */
    54  union sctp_addr {
    55          struct sockaddr_inet sa;        /* Large enough for both address families */
    56          struct sockaddr_in v4;
    57          struct sockaddr_in6 v6;
    58  };

Before it was sockaddr but the patch changed it to sockaddr_inet. I think
the 'c' in "%pISc" means it should actually be the sockaddr_in6...  It's
a union so this is all fine...  Should I just silence the warning for
sockaddr_inet?  The code to print it is in lib/vsprintf.c.

lib/vsprintf.c
  1622  static noinline_for_stack
  1623  char *ip_addr_string(char *buf, char *end, const void *ptr,
  1624                       struct printf_spec spec, const char *fmt)
  1625  {
  1626          char *err_fmt_msg;
  1627  
  1628          if (check_pointer(&buf, end, ptr, spec))
  1629                  return buf;
  1630  
  1631          switch (fmt[1]) {
  1632          case '6':
  1633                  return ip6_addr_string(buf, end, ptr, spec, fmt);
  1634          case '4':
  1635                  return ip4_addr_string(buf, end, ptr, spec, fmt);
  1636          case 'S': {
  1637                  const union {
  1638                          struct sockaddr         raw;
  1639                          struct sockaddr_in      v4;
  1640                          struct sockaddr_in6     v6;
  1641                  } *sa = ptr;
  1642  
  1643                  switch (sa->raw.sa_family) {
  1644                  case AF_INET:
  1645                          return ip4_addr_string_sa(buf, end, &sa->v4, spec, fmt);
  1646                  case AF_INET6:
  1647                          return ip6_addr_string_sa(buf, end, &sa->v6, spec, fmt);
  1648                  default:
  1649                          return error_string(buf, end, "(einval)", spec);
  1650                  }}
  1651          }
  1652  
  1653          err_fmt_msg = fmt[0] == 'i' ? "(%pi?)" : "(%pI?)";
  1654          return error_string(buf, end, err_fmt_msg, spec);
  1655  }

regards,
dan carpenter

