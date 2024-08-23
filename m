Return-Path: <linux-sctp+bounces-211-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 263A395CC8E
	for <lists+linux-sctp@lfdr.de>; Fri, 23 Aug 2024 14:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 520BD1C216A4
	for <lists+linux-sctp@lfdr.de>; Fri, 23 Aug 2024 12:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0F9185B60;
	Fri, 23 Aug 2024 12:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OH0yIWpN"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8161C566A;
	Fri, 23 Aug 2024 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724416930; cv=none; b=Y7RLj7OfUaPzWQXC5a/Jxml/qIJmWflXW52aBqr5G/htaZiKth7B1ULhimfIIgqCRll+ZgkVC4uJiUlIy0X8QoZFFcyRvqNxOzKTvtiVFOnpIOF46R2UNnVKRFOf11XIcoe7GeZRFdPFLsOGk9290nl0xgdFVXD+cOTPu8K9QPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724416930; c=relaxed/simple;
	bh=HfIU2mD/YlJUBd0kQxBBtiisaJ8aGjmalu4uRIe6ojI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=SNGjL5Z8ZOy+Hb4FbjV8qN+GR5XN9FBUZYXb124cJiLXjSTySKesOBKS+uQBg0v+pbaqU0Tck4MNY0Bu+6/YqphLMmuTtoixQU6M8/FOZuF/eNQLJWabGCsRC7k2PbKdsiqwrgR8sHjmLnTNfP8c8sYPtrcuIUu+sQ5xD4aWgBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OH0yIWpN; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6bf7658f4aaso9261156d6.0;
        Fri, 23 Aug 2024 05:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724416928; x=1725021728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYG7eomrfsT/3+ZKJ0euNwIh5HffV5LSzIoWPqaYnjE=;
        b=OH0yIWpNQUISSShMBJm5Dx1BXVc477VgYSglKvD4Xmhxy658ElTEwNEUhc54gOxWJw
         jQPEDm6pYymgBTW4v52vtinTqBInLQH482Ava7daIwJb49g/gglvO1VlFjYFuIVHpYm4
         fMgZHALi/Ew5bAkMc5IPybTNa4AO+hOC56ZWjLcdo5BvB/LvCws5j6UBxh1PRJGIBJ3R
         xuo3mNKgOHKrM5tKkGEcEz1i1cBIEQiLbnLAjWKDaH4cCCjWKK6/kFR2U5+XLlFaAK76
         XuJfkNVf/m6YvMwNE77Bgm1g8xamO+r7qCwJ+vhky93ZjsxptDjy77CFzHco86qEZF3S
         gJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724416928; x=1725021728;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fYG7eomrfsT/3+ZKJ0euNwIh5HffV5LSzIoWPqaYnjE=;
        b=EzknfoEn2WzYRyrvhNCvHCeWWJd1dcDe9JmmDd74ZIXkWInVeE4GFWZkHabYW7Cnrw
         SSaIr+ho9Zxxn3QOf7B+bPnPl+bV2LTSFqUY8RsdTRgswI1Rz1t5N6N8182wklYfpk0Y
         2vEx2wb6eAHPwFItTiaeXg/H3OSsu1UJ053oRooNbSVTfSc0r4kRzQwIaRhWu1zmv2eI
         xKFvtKTJmMy1evL0JdXJU0nfYgGMKh4PTRPBwwWaAGCuRDW01HfpFB+wQsmYUS5wXXl+
         W1C+HbKlFDNHA8NMpOD6+bpccyvs5N0mErUaPYz8lyJ9nhHke2PaxJQd/H6VflVXLGkm
         3DmA==
X-Forwarded-Encrypted: i=1; AJvYcCVMUxARb9AJ46QD9I5II6G+ujf6t/wt+dWbSzB6zGtUH7oOtKJvnQPi/ggPFc0aAFT2AdRRDK1Iy7U5@vger.kernel.org, AJvYcCVkKJO5zVsDU7hB3aO571FddYbH4GfxZwtWC2VROQnK6Pa8f0gDWFHnXrA9TCQ/PpUWSZms1XSlp786hQOaMxMRC1So1eGQ@vger.kernel.org, AJvYcCWZzCP6HIKpR07aYmXY2i7MO08zfqNToaw67IJBuwdDh33GpIUTxIPwP3HameWmO6L/n2a5YU9m7po/jg==@vger.kernel.org, AJvYcCXJEzL0Le0U+IR4CfX8aKN5y11xJRXuMWG4bA8TrurwPFiIwqnrlWu7mRo1OWBASrFnNUWPr4TOOieT@vger.kernel.org
X-Gm-Message-State: AOJu0YzVJtoNnwkBcU48r5/Hhfy7VZQIgdpA8pa4lppn26LiHioWfyRv
	gyb4brT9SNIExf4c6vEAh4jlvXBxuMJy03uupDKqARWEQXYp+P8c
X-Google-Smtp-Source: AGHT+IGaHEMkn+iihmrv+AHr1c6bVbL+QMVs8gR3y5k+FHx18Oj9W65iRD/oh1Xl96U/qDlOeuL31Q==
X-Received: by 2002:a05:6214:46a0:b0:6b5:58e8:8f0c with SMTP id 6a1803df08f44-6c16dc278a7mr25397836d6.7.1724416928172;
        Fri, 23 Aug 2024 05:42:08 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162dccdccsm17887586d6.108.2024.08.23.05.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 05:42:07 -0700 (PDT)
Date: Fri, 23 Aug 2024 08:42:06 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Alexandra Winter <wintera@linux.ibm.com>, 
 Thorsten Winkler <twinkler@linux.ibm.com>, 
 David Ahern <dsahern@kernel.org>, 
 Jay Vosburgh <jv@jvosburgh.net>, 
 Andy Gospodarek <andy@greyhouse.net>, 
 Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>, 
 Sean Tranchetti <quic_stranche@quicinc.com>, 
 Paul Moore <paul@paul-moore.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, 
 Cong Wang <xiyou.wangcong@gmail.com>, 
 Jiri Pirko <jiri@resnulli.us>, 
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
 Xin Long <lucien.xin@gmail.com>, 
 Martin Schiller <ms@dev.tdt.de>
Cc: netdev@vger.kernel.org, 
 linux-s390@vger.kernel.org, 
 linux-security-module@vger.kernel.org, 
 linux-sctp@vger.kernel.org, 
 linux-x25@vger.kernel.org
Message-ID: <66c8839ee9267_19c4cc294e@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240822-net-spell-v1-1-3a98971ce2d2@kernel.org>
References: <20240822-net-spell-v1-0-3a98971ce2d2@kernel.org>
 <20240822-net-spell-v1-1-3a98971ce2d2@kernel.org>
Subject: Re: [PATCH net-next 01/13] packet: Correct spelling in if_packet.h
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Simon Horman wrote:
> Correct spelling in if_packet.h
> As reported by codespell.
> 
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Signed-off-by: Simon Horman <horms@kernel.org>

Acked-by: Willem de Bruijn <willemb@google.com>

