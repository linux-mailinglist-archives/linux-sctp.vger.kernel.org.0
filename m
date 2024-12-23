Return-Path: <linux-sctp+bounces-297-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F029FB0B8
	for <lists+linux-sctp@lfdr.de>; Mon, 23 Dec 2024 16:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 135E716343F
	for <lists+linux-sctp@lfdr.de>; Mon, 23 Dec 2024 15:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CCA13A26F;
	Mon, 23 Dec 2024 15:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HS9XeUBk"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0B8632;
	Mon, 23 Dec 2024 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734967671; cv=none; b=E4/OjfXMcx8HGT3wMhiqkfuwZEK7cAUwZuH9OkKcN2jpLcwXiVmV8y3DB1Qrm4UcKuQ9nE4TB21hzdV5fSWlVV8G6cGzwgugkDaG68DbD/lPI2XJt1bcwCXlR1SUmugfMUj6XY4ZACydz+XQFkFjZVFrOLzDjURTHrqkFzLiVO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734967671; c=relaxed/simple;
	bh=JyH1FAdbSmm3pLOkb+mbQ89WYP/YUmQ97qwMR+LlnLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r8Tbo46VWqpUeHN4R+UccCu0f+CpMdX9QbNUU/nvH0sU8Iym9BNADRKUBsADS5crJaYLpIo/P24lkK69yTHfR+PuAMK0EralMTAp6lYd3wE5cO6osv6MkN7zVeqtSW81yi0AezDvU+QPpRz/6irr5EFUKulHhBppg6HWqudbQKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HS9XeUBk; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a815ed5acfso14180095ab.0;
        Mon, 23 Dec 2024 07:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734967668; x=1735572468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJliU74WixiH/rdJlK8HJAJqnkGXZXBJ10gnZhmP0p0=;
        b=HS9XeUBk3eIKZ5smskF6TWme4j05QsoprDZgw2/YtWWHz78+vWcEU3tscLmx5BhI6Y
         LpXoJLvmu+Gu3dDIkr/utww8O+6ybWUYnh2qGkNv3qYmRMcrTHVAm9eUw3utH7Di/5CH
         Byq9nP38ughkBI+XpRWXPeKnwVmJvCJpqz4yep2pSEX3rcL4CFGJASeNOUG9i68XBuMV
         tEYjes6uvr1p1RhjaFATtqzwZLXu4WPCq9EAPeT9xu0UEfgUKrUY9W2SbmNOEgbmNxN6
         UbMcHjrv6mt+2olIcGg3oa+WALYlpmslmEDL/LXOM2chaDHHQab1Zk7h//mQazh6QUj6
         ZWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734967668; x=1735572468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJliU74WixiH/rdJlK8HJAJqnkGXZXBJ10gnZhmP0p0=;
        b=SamLV2ZXfvutxep6cbzUPgEahWhl1Ad9heVvzECUe+keOnX1TEng5r9X30scpTO90e
         7lAoIQGjVxQA/fgjpFhPq0g1d2L//Ef1Sdm6oEHqfOA7MNJltuvIUHv6aSNKCpFRc7wA
         Uj2wAAg7yijccvnDXf8lbfj3rstDB8TftN92XZPU0aXsYvQ+GD9kya17fYsCUsYGhzn/
         L465UvQZ8IUpr7rBkHlfbOhHAJXVkz6A1JP/frSiJfQL0gVIzcZBVqhl/ok9gQHZwzlr
         e+R6iKWm+7G9T6VYRTlgxe6mL+sqOMdfh5ebvdA7pJw9RZw9gghn9QVC/sY3yd+7vvlJ
         3m9Q==
X-Forwarded-Encrypted: i=1; AJvYcCURHDOuk6lNcWaKyT0hAWW6TiB97YLftN54AcQTSGrS8QfsN7nkV5Nej+//aUaW9djcdjwY08esVVqQ@vger.kernel.org, AJvYcCUnvsdKQZjhfGlCtB+9+a0QbuF6ww8HSjOS0xm0bfNrnIsNkMos/mPAXynXs/N1ZoYWNMxqvq9r@vger.kernel.org, AJvYcCVBdJVyHFhLnP7VpgxgOxVMA3eB5VPUlXHMtW1nfbJmzrtTYHoOj++PTJgkJaNNZQBm4r3K0Y48@vger.kernel.org
X-Gm-Message-State: AOJu0YyFHWFi5Ah/eg3r67W8wa87SqzEMPhrgT3pHUCQbAafRq2Hie05
	g+Ya8H0+rneECxGUTFA33AgK3xx18SoOc3BswKdZGt5VMocw9uuPcQ7CCl6kaaiNF0BJQnYuEJN
	WTymTbYPV560+/qmouJDLBPMz7OQ=
X-Gm-Gg: ASbGncsFsnUl+B28irm1wqpPBqh5EA5rGFS0mDwJo5elSrdFOU5iIgN0NGwgd98Aaim
	jftOAbSDaVnNfSDWGi+1cEGBWl2Lkzuu8U6jLbg==
X-Google-Smtp-Source: AGHT+IH/yd2/FRMjA6DqP7gtA7Niuqm2CSRtuz1jCIPMRQ0s/FjoRYREsTsJwRxjlEcf4N0djY9BgQY+71+z/lM2LoY=
X-Received: by 2002:a05:6e02:180d:b0:3a7:d792:d6c0 with SMTP id
 e9e14a558f8ab-3c2d5918a9bmr128839685ab.20.1734967668519; Mon, 23 Dec 2024
 07:27:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219162114.2863827-1-kniv@yandex-team.ru>
In-Reply-To: <20241219162114.2863827-1-kniv@yandex-team.ru>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 23 Dec 2024 10:27:37 -0500
Message-ID: <CADvbK_dcUiBQLCte44PxS3HNNogzHys=cL3v1=Ukm+_xMtvMAA@mail.gmail.com>
Subject: Re: [PATCH] net/sctp: Prevent autoclose integer overflow in sctp_association_init()
To: Nikolay Kuratov <kniv@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-sctp@vger.kernel.org, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
	Neil Horman <nhorman@tuxdriver.com>, Vlad Yasevich <vyasevich@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 11:21=E2=80=AFAM Nikolay Kuratov <kniv@yandex-team.=
ru> wrote:
>
> While by default max_autoclose equals to INT_MAX / HZ, one may set
> net.sctp.max_autoclose to UINT_MAX. There is code in
> sctp_association_init() that can consequently trigger overflow.
>
> Cc: stable@vger.kernel.org
> Fixes: 9f70f46bd4c7 ("sctp: properly latch and use autoclose value from s=
ock to association")
> Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
> ---
>  net/sctp/associola.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/sctp/associola.c b/net/sctp/associola.c
> index c45c192b7878..0b0794f164cf 100644
> --- a/net/sctp/associola.c
> +++ b/net/sctp/associola.c
> @@ -137,7 +137,8 @@ static struct sctp_association *sctp_association_init=
(
>                 =3D 5 * asoc->rto_max;
>
>         asoc->timeouts[SCTP_EVENT_TIMEOUT_SACK] =3D asoc->sackdelay;
> -       asoc->timeouts[SCTP_EVENT_TIMEOUT_AUTOCLOSE] =3D sp->autoclose * =
HZ;
> +       asoc->timeouts[SCTP_EVENT_TIMEOUT_AUTOCLOSE] =3D
> +               (unsigned long)sp->autoclose * HZ;
>
>         /* Initializes the timers */
>         for (i =3D SCTP_EVENT_TIMEOUT_NONE; i < SCTP_NUM_TIMEOUT_TYPES; +=
+i)
> --
> 2.34.1
>
Acked-by: Xin Long <lucien.xin@gmail.com>

